#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1
source ./scripts/helpers.sh
root_dir=$(pwd)

# yay
op 'Installing yay...' \
  'sudo pacman -Syu yay' \
  'Successfully installed yay.' \
  'Failed to install yay.' || exit 1

# brew
cd "$root_dir" || exit 1
source ./steps/brew.sh || exit $!
cd "$root_dir" || exit 1

# glab
source ./steps/glab.sh || exit $!
cd "$root_dir" || exit 1


# github-cli
op 'Installing gh...' \
  'brew install gh' \
  'Successfully installed gh.' \
  'Failed to install gh.' || exit 1

print_info 'Would you like to authenticate gh now? (y/n) '
read -pr '' confirm
if [[ $confirm == [YySs] ]]; then
  gh auth login || exit 1
fi

# haskell
op 'Installing ghcup dependencies...' \
  'yes | head -n1 | sudo pacman -Syu curl gcc gmp make ncurses coreutils xz' \
  'Successfully installed ghcup dependencies.' \
  'Failed to install ghcup dependencies.' || exit 1

op 'Installing ghcup...' \
  'curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh' \
  'Successfully installed ghcup.' \
  'Failed to install ghcup.' || exit 1

source "$HOME/.ghcup/env"

# Further packages
cd "$root_dir" || exit 1
op 'Installing remaining pacman packages...' \
  'yes | head -n1 | sudo pacman -Sy - < packages.txt' \
  'Successfully installed remaining packages.' \
  'Failed to install remaining packages.' || exit 1

op 'Installing remaining aur packages...' \
  'yay -S --needed --noconfirm - < aur-packages.txt' \
  'Successfully installed remaining aur packages.' \
  'Failed to install remaining aur packages.' || exit 1

# disable cache
sync
echo 1 | sudo tee /proc/sys/vm/dirty_expire_centisecs
echo 1 | sudo tee /proc/sys/vm/dirty_writeback_centisecs
echo 1 | sudo tee /proc/sys/vm/drop_caches

# gnome config
cd "$root_dir" || exit 1
dconf load / <dconf-settings.ini
