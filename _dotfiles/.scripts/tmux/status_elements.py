#!/usr/bin/env python3
"""
Tmux status bar elements with caching
Usage: status_elements.py <element>
Elements: cpu_mem, battery, disk_usage, network, uptime, window_count, git_branch
"""

import sys
import os
import time
import subprocess
import json
from pathlib import Path

# Cache directory
CACHE_DIR = Path.home() / ".cache" / "tmux-status"
CACHE_DIR.mkdir(parents=True, exist_ok=True)
CACHE_FILE = CACHE_DIR / "status_cache.json"
CACHE_TTL = 60  # 1 minute

# Tokyo Night color scheme
COLORS = {
    "bg": "#1a1b26",
    "fg": "#a9b1d6",
    "blue": "#7aa2f7",
    "green": "#9ece6a",
    "yellow": "#e0af68",
    "red": "#f7768e",
    "purple": "#bb9af7",
    "cyan": "#7dcfff",
    "comment": "#565f89",
}


def load_cache():
    """Load cache from file"""
    if not CACHE_FILE.exists():
        return {}
    try:
        with open(CACHE_FILE, 'r') as f:
            return json.load(f)
    except (json.JSONDecodeError, IOError):
        return {}


def save_cache(cache):
    """Save cache to file"""
    try:
        with open(CACHE_FILE, 'w') as f:
            json.dump(cache, f)
    except IOError:
        pass


def get_cached(element):
    """Get cached value if still valid"""
    cache = load_cache()
    if element in cache:
        timestamp, value = cache[element]
        if time.time() - timestamp < CACHE_TTL:
            return value
    return None


def set_cached(element, value):
    """Set cached value with current timestamp"""
    cache = load_cache()
    cache[element] = (time.time(), value)
    save_cache(cache)


def get_cpu_mem():
    """Get CPU and memory usage"""
    try:
        # Get CPU usage
        result = subprocess.run(
            ['top', '-l', '1', '-n', '0'],
            capture_output=True,
            text=True,
            timeout=2
        )
        cpu_line = [l for l in result.stdout.split('\n') if 'CPU usage' in l]
        if not cpu_line:
            return ""
        
        cpu_usage = cpu_line[0].split()[2].rstrip('%')
        cpu_int = int(float(cpu_usage))
        
        # Get memory usage
        result = subprocess.run(['vm_stat'], capture_output=True, text=True, timeout=2)
        if result.returncode != 0:
            return f"#[fg={COLORS['blue']}]CPU:{cpu_int}%"
        
        lines = result.stdout.split('\n')
        page_size = None
        for line in lines:
            if 'page size' in line:
                page_size = int(line.split()[-2])
                break
        
        if not page_size:
            return f"#[fg={COLORS['blue']}]CPU:{cpu_int}%"
        
        # Parse memory stats
        stats = {}
        for line in lines:
            if 'Pages free' in line:
                stats['free'] = int(line.split()[-1].rstrip('.'))
            elif 'Pages active' in line:
                stats['active'] = int(line.split()[-1].rstrip('.'))
            elif 'Pages inactive' in line:
                stats['inactive'] = int(line.split()[-1].rstrip('.'))
            elif 'Pages wired down' in line:
                stats['wired'] = int(line.split()[-1].rstrip('.'))
        
        if not all(k in stats for k in ['free', 'active', 'inactive', 'wired']):
            return f"#[fg={COLORS['blue']}]CPU:{cpu_int}%"
        
        # Calculate percentages
        mem_used = stats['active'] + stats['wired']
        mem_total = sum(stats.values())
        mem_percent = int((mem_used * 100) / mem_total) if mem_total > 0 else 0
        
        # Color based on usage
        cpu_color = COLORS['green'] if cpu_int < 50 else (COLORS['yellow'] if cpu_int < 80 else COLORS['red'])
        mem_color = COLORS['green'] if mem_percent < 50 else (COLORS['yellow'] if mem_percent < 80 else COLORS['red'])
        
        return f"#[fg={cpu_color}]CPU:{cpu_int}%#[fg={COLORS['comment']}] #[fg={mem_color}]MEM:{mem_percent}%"
    except (subprocess.TimeoutExpired, ValueError, IndexError, KeyError, ZeroDivisionError, FileNotFoundError):
        return ""


def get_battery():
    """Get battery status"""
    try:
        result = subprocess.run(
            ['pmset', '-g', 'batt'],
            capture_output=True,
            text=True,
            timeout=2
        )
        if result.returncode != 0:
            return ""
        
        lines = result.stdout.split('\n')
        for line in lines:
            if '%' in line:
                parts = line.split()
                for part in parts:
                    if '%' in part:
                        battery_str = part.rstrip('%;')
                        # Handle both "100%" and "100" formats
                        if battery_str.isdigit():
                            battery_percent = int(battery_str)
                            # Check for charging status
                            line_lower = line.lower()
                            battery_status = 'C' if ('charging' in line_lower or 'charged' in line_lower or 'finishing' in line_lower) else 'D'
                            
                            # Determine color and label
                            if battery_status == 'C':
                                label = "CHG"
                                color = COLORS['green']
                            elif battery_percent > 50:
                                label = "BAT"
                                color = COLORS['green']
                            elif battery_percent > 20:
                                label = "BAT"
                                color = COLORS['yellow']
                            else:
                                label = "BAT"
                                color = COLORS['red']
                            
                            return f"#[fg={color}]{label}{battery_percent}%"
        return ""
    except (subprocess.TimeoutExpired, ValueError, IndexError, FileNotFoundError):
        return ""


def get_disk_usage():
    """Get disk usage"""
    try:
        result = subprocess.run(
            ['df', '-h', '/'],
            capture_output=True,
            text=True,
            timeout=2
        )
        if result.returncode != 0:
            return ""
        
        lines = result.stdout.split('\n')
        if len(lines) < 2:
            return ""
        
        parts = lines[1].split()
        if len(parts) < 5:
            return ""
        
        disk_used = int(parts[4].rstrip('%'))
        
        # Color based on usage
        if disk_used < 70:
            color = COLORS['green']
        elif disk_used < 90:
            color = COLORS['yellow']
        else:
            color = COLORS['red']
        
        return f"#[fg={color}]DISK{disk_used}%"
    except (subprocess.TimeoutExpired, ValueError, IndexError, FileNotFoundError):
        return ""


def get_network():
    """Get network activity indicator"""
    try:
        result = subprocess.run(
            ['route', 'get', 'default'],
            capture_output=True,
            text=True,
            timeout=2
        )
        if result.returncode != 0:
            return f"#[fg={COLORS['comment']}]NET"
        
        interface = None
        for line in result.stdout.split('\n'):
            if 'interface:' in line:
                interface = line.split()[-1]
                break
        
        if not interface:
            return f"#[fg={COLORS['comment']}]NET"
        
        # Check for network activity
        result = subprocess.run(
            ['netstat', '-ib'],
            capture_output=True,
            text=True,
            timeout=2
        )
        if result.returncode == 0:
            for line in result.stdout.split('\n'):
                if interface in line:
                    parts = line.split()
                    if len(parts) >= 7:
                        bytes_in = int(parts[6]) if parts[6].isdigit() else 0
                        if bytes_in > 0:
                            return f"#[fg={COLORS['green']}]NET"
        
        return f"#[fg={COLORS['comment']}]NET"
    except (subprocess.TimeoutExpired, ValueError, IndexError, FileNotFoundError):
        return f"#[fg={COLORS['comment']}]NET"


def get_uptime():
    """Get session uptime"""
    try:
        result = subprocess.run(
            ['tmux', 'display-message', '-p', '#{session_created}'],
            capture_output=True,
            text=True,
            timeout=1
        )
        if result.returncode != 0:
            return ""
        
        session_start = int(result.stdout.strip())
        if session_start == 0:
            return ""
        
        current_time = int(time.time())
        uptime_seconds = current_time - session_start
        
        if uptime_seconds < 0:
            return ""
        
        if uptime_seconds < 3600:
            uptime_display = f"{uptime_seconds}s"
        elif uptime_seconds < 86400:
            hours = uptime_seconds // 3600
            mins = (uptime_seconds % 3600) // 60
            uptime_display = f"{hours}h{mins}m"
        else:
            days = uptime_seconds // 86400
            hours = (uptime_seconds % 86400) // 3600
            uptime_display = f"{days}d{hours}h"
        
        return f"#[fg={COLORS['cyan']}]UP {uptime_display}"
    except (subprocess.TimeoutExpired, ValueError, IndexError, FileNotFoundError):
        return ""


def get_window_count():
    """Get window and pane count"""
    try:
        result = subprocess.run(
            ['tmux', 'list-windows'],
            capture_output=True,
            text=True,
            timeout=1
        )
        if result.returncode != 0:
            return ""
        
        window_count = len([l for l in result.stdout.split('\n') if l.strip()])
        
        result = subprocess.run(
            ['tmux', 'list-panes'],
            capture_output=True,
            text=True,
            timeout=1
        )
        if result.returncode != 0:
            return ""
        
        pane_count = len([l for l in result.stdout.split('\n') if l.strip()])
        
        return f"#[fg={COLORS['purple']}]WIN{window_count}#[fg={COLORS['comment']}]/#[fg={COLORS['cyan']}]PAN{pane_count}"
    except (subprocess.TimeoutExpired, ValueError, IndexError, FileNotFoundError):
        return ""


def get_git_branch():
    """Get git branch (not cached, always fresh)"""
    try:
        # Get current pane path from tmux
        result = subprocess.run(
            ['tmux', 'display-message', '-p', '#{pane_current_path}'],
            capture_output=True,
            text=True,
            timeout=1
        )
        if result.returncode != 0:
            return ""
        
        path = result.stdout.strip()
        git_dir = Path(path) / '.git'
        
        if not git_dir.exists():
            return ""
        
        result = subprocess.run(
            ['git', 'branch', '--show-current'],
            cwd=path,
            capture_output=True,
            text=True,
            timeout=1
        )
        if result.returncode != 0:
            return ""
        
        branch = result.stdout.strip()
        if not branch:
            return ""
        
        # Truncate long branch names
        if len(branch) > 15:
            branch = branch[:12] + "..."
        
        return f"#[fg={COLORS['purple']}]GIT:{branch}"
    except (subprocess.TimeoutExpired, ValueError, IndexError, FileNotFoundError):
        return ""


def main():
    if len(sys.argv) < 2:
        print("")
        sys.exit(0)
    
    element = sys.argv[1]
    
    # Git branch is always fresh (no cache)
    if element == "git_branch":
        result = get_git_branch()
        print(result)
        return
    
    # Check cache first
    cached = get_cached(element)
    if cached is not None:
        print(cached)
        return
    
    # Get fresh value
    handlers = {
        "cpu_mem": get_cpu_mem,
        "battery": get_battery,
        "disk_usage": get_disk_usage,
        "network": get_network,
        "uptime": get_uptime,
        "window_count": get_window_count,
    }
    
    if element not in handlers:
        print("")
        sys.exit(0)
    
    result = handlers[element]()
    
    # Cache the result
    if result:
        set_cached(element, result)
    
    print(result)


if __name__ == "__main__":
    main()

