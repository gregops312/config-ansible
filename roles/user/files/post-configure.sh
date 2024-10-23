#!/usr/bin/env bash

set -euo pipefail

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

cat ~/.ssh/id_rsa.pub | xclip -sel clip
