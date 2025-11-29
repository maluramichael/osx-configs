" Set leader key first (before loading any modules)
let mapleader = " "

lua << EOF
require("options")
require("remap")
require("plugins")
EOF

