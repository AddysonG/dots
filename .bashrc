#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias man='batman'
PS1='[\u@\h \W]\$ '

nnohup() {
    nohup "$@" >/dev/null >&1 &
}

bats() {
    BATS_RUN_SKIPPED=true command bats *.bats
}

# Include additional bin directories on PATH
export PATH=~/bin:$PATH
export PATH="$PATH:/home/addys/.local/bin"

export EDITOR=nvim
export SUDO_EDITOR=nvim

export FZF_DEFAULT_OPTS=" \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

eval "$(starship init bash)"
eval "$(zoxide init bash)"
