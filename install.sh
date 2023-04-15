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
op 'Installing homebrew...' \
  ' /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo '\''eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'\'') >> "$HOME/.zprofile"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    sudo pacman -S base-devel
  ' \
  'Succesfully installed homebrew.' \
  'Failed to install homebrew.' || exit 1

# glab
op 'Installing glab...' \
  'brew install glab' \
  'Successfully installed glab.' \
  'Failed to install glab.' || exit 1

print_info 'Would you like to authenticate glab now? (y/n) '
read -pr '' confirm
if [[ $confirm == [YySs] ]]; then
  firefox 'https://gitlab.com/-/profile/personal_access_tokens'
  print_info 'Input your access token:'
  glab auth login --stdin || exit 1
fi

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
dconf load / < dconf-settings.ini