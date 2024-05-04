# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#DISABLE_UNTRACKED_FILES_DIRTY="true"
#ZSH_THEME="steeef"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#bindkey '^w' autosuggest-execute
#bindkey '^e' autosuggest-accept
#bindkey '^u' autosuggest-toggle
#bindkey '^L' vi-forward-word
#bindkey '^k' up-line-or-search
#bindkey '^j' down-line-or-search

bindkey jj vi-cmd-mode

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR=/opt/homebrew/bin/nvim

plugins=(
	brew
	fzf 
	docker 
	docker-compose 
	ripgrep 
	pyenv
)

# no need for that right now - plugins managed manually
#source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Git
alias g="git"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# GO
export GOPATH='/Users/yarinbenado/go'

# VIM
alias vi="/opt/homebrew/bin/nvim"
alias v=vi
alias vim=vi

alias ls="eza --icons --sort type -a"
alias ll="eza --icons --long --sort type -a"
alias l="eza --icons --long --sort type -a"
alias lt="eza --tree --level=2 --long --icons --git"


alias cat=bat --theme="grubox-dark"
#alias grep=rg
#alias find=fd


export PATH="$HOME/.okta/bin:$HOME/bin:$PATH"

alias h='cd ~/develop/code/honeyfy'
alias d='cd ~/develop/code/dbt'
alias dl='cd ~/develop/code/gong-data-lake'

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_11_HOME='/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home'

alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'

# default to Java 11
java11

export PGPASSWORD=postgres


# navigation
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

eval "$(zoxide init zsh)"

export PATH="$PATH:/Users/yarinbenado/bin"
