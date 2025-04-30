# git
alias g="git"

# through path for nvim
export PATH=$PATH:/home/takao/app/nvim-linux64/bin
# alias for nvim
alias v='nvim'

# starship
eval "$(starship init bash)"

# node
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# nvm end
# pnpm
export PNPM_HOME="/home/takao/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# node end

# gopath
export PATH=$PATH:/usr/local/go/bin

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


. "/home/takao/.deno/env"
. "$HOME/.cargo/env"
