#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1
source ../scripts/helpers.sh || exit 1

chsh -s "$(which zsh)"

op 'Installing oh-my-zsh...' \
  ' [[ -d $HOME/.oh-my-zsh ]] && rm --interactive=never -r $HOME/.oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ' \
  'Successfully installed oh-my-zsh.' \
  'Failed to install oh-my-zsh.' || exit $?

op 'Installing base .zshrc...' \
  ' [[ -f $HOME/.zshrc ]] && rm --interactive=never "$HOME/.zshrc"
    curl https://raw.githubusercontent.com/minhanhhere/developer-tools/main/powerlevel10k/.zshrc -o ~/.zshrc
  ' \
  'Successfully installed base .zshrc.' \
  'Failed to install base .zshrc.' || exit $?

op 'Installing zsh components...' \
  ' git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    echo '"'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh'"' >>~/.zshrc

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
    echo '"'source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'"' >>~/.zshrc

    mkdir -p ~/.zsh && cd ~/.zsh && {
      curl -O '"'https://raw.githubusercontent.com/minhanhhere/developer-tools/main/powerlevel10k/git-completion.bash'"'
      cd -
    }

    echo "

    # Load Git completion
    zstyle '"':completion:*:*:git:*'"' script ~/.zsh/git-completion.bash
    fpath=(~/.zsh \$fpath)
    autoload -Uz compinit && compinit
    " >>~/.zshrc' \
  'Successfully installed zsh components.' \
  'Failed to install zsh components.' || exit $?

p10k_out=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

op 'Installing powerlevel10k...' \
  " [[ -d $p10k_out ]] && yes | rm -r $p10k_out
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $p10k_out
    " \
  'Successfully installed powerlevel10k' \
  'Failed to install powerlevel10k'
