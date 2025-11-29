#!/bin/sh

# thanks to https://github.com/microsoft/vscode/issues/42994#issuecomment-365308504
cat extensions.list | xargs -L1 code --install-extension