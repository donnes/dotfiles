# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Android Studio
if [[ $OSTYPE == 'darwin'* ]]; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/tools/bin
    export PATH=$PATH:$ANDROID_HOME/platform-tools
fi

# ZSH
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git)

# Oh My ZSH
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# WSL Host Patcher
if [[ -f "/mnt/c/Users/donal/wsl/WSLHostPatcher.exe" ]]; then
    /mnt/c/Users/donal/wsl/WSLHostPatcher.exe
fi

# wsl zsh same directory
if [[ $OSTYPE == 'linux-gnu'* ]]; then
    current_path() {
        printf "\e]9;9;%s\e\\" "$(wslpath -w "$(pwd)")"
    }
    precmd_functions+=(current_path)
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
if [[ $OSTYPE == 'darwin'* ]]; then
    export PNPM_HOME="/Users/$LOGNAME/Library/pnpm"
    export PATH="$PNPM_HOME:$PATH"
fi

if [[ $OSTYPE == 'linux-gnu'* ]]; then
    export PNPM_HOME="/home/$LOGNAME/.local/share/pnpm"
    case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
fi

# rbenv
eval "$(rbenv init - zsh)"

# fnm
eval "$(fnm env --use-on-cd)"

# atuin
eval "$(atuin init zsh)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
