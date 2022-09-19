# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "jeffreytse/zsh-vi-mode"
zplug "romkatv/powerlevel10k", as:theme, depth:1

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
zstyle :compinstall filename '/home/cole/.zshrc'


autoload -Uz compinit
compinit
# End of lines added by compinstall
alias ls='ls --color=auto'
alias sl='ls'
alias code="vscodium"
alias youtube-mp3="youtube-dl --extract-audio --audio-format mp3"
eval $(keychain --eval --quiet id_rsa ~/.ssh/id_rsa)


PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f
$ '
alias dia='dia --integrated'






export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi




[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/cole/.sdkman"
[[ -s "/home/cole/.sdkman/bin/sdkman-init.sh" ]] && source "/home/cole/.sdkman/bin/sdkman-init.sh"
zplug load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
