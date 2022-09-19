#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


eval $(keychain --eval --quiet id_rsa ~/.ssh/id_rsa)
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"  # This line was causing the problem
#eval "$(pyenv init --path)"
set -o vi

alias dia='dia --integrated'
export ANDROID_HOME="/home/cole/Android/Sdk"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/cole/.sdkman"
[[ -s "/home/cole/.sdkman/bin/sdkman-init.sh" ]] && source "/home/cole/.sdkman/bin/sdkman-init.sh"

if [ -f ~/.aliases ]; then 
    . ~/.aliases
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
