# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/takao/.zsh/completions:"* ]]; then export FPATH="/home/takao/.zsh/completions:$FPATH"; fi

# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

setopt print_eight_bit

# fzf
# fzf history
function fzf-select-history() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# cdr自体の設定
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
fi

# fzf cdr
function fzf-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --reverse)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-cdr
setopt noflowcontrol
bindkey '^q' fzf-cdr
# fzf end


# git
alias g="git"

# through path for nvim
export PATH=$PATH:/home/takao/app/nvim-linux-x86_64/bin
# alias for nvim
alias v='nvim'

# through path for github cli
export PATH=$PATH:/home/takao/app/gh_2.67.0_linux_amd64/bin

# starship
eval "$(starship init zsh)"

# node
alias nrdev="npm run dev"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
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
export PATH=$PATH:~/go/bin

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# through PATH deno
. "/home/takao/.deno/env"

export OPENAI_API_KEY="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"


# rust
export PATH=$PATH:/home/takao/.cargo/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/takao/google-cloud-sdk/path.zsh.inc' ]; then . '/home/takao/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/takao/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/takao/google-cloud-sdk/completion.zsh.inc'; fi
