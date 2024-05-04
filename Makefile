SHELL = /bin/bash

HOMEBREW := $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
BASE_DIR := $(abspath $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))

OSFLAG :=
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	OSFLAG = "Linux"
endif
ifeq ($(UNAME_S),Darwin)
	OSFLAG = "Darwin"
endif


.PHONY: brew zsh tmux nvim git psqlrc wezterm starship
all: brew zsh tmux nvim git psqlrc wezterm starship

brew:
	which brew || ruby -e ${HOMEBREW}
	brew bundle
	brew update


zsh:
	if [ ! -d ~/.oh-my-zsh/.git ]; then \
		git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh; \
	fi
	
	stow --target ${HOME} zsh
	mkdir -p ${HOME}/.zsh-custom/plugins
	#cd ${HOME}/.zsh-custom/plugins/ && rm -rf zsh-syntax-highlighting && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
	#cd ${HOME}/.zsh-custom/plugins/ && rm -rf zsh-history-substring-search && git clone https://github.com/zsh-users/zsh-history-substring-search.git
	cd ${HOME}/.zsh-custom/plugins/ && rm -rf zsh-completions && git clone https://github.com/zsh-users/zsh-completions

tmux:
	if [ ! -d ~/.config/tmux/plugins/tpm ]; then \
		git clone https://github.com/tmux-plugins/tpm.git ~/.config/tmux/plugins/tpm && ~/.config/tmux/plugins/tpm/bin/install_plugins; \
	fi
	stow --target ${HOME} tmux

nvim:
	stow --target ${HOME} nvim

git:
	rm -f ${HOME}/.gitconfig.local
	stow --targe ${HOME} git
	$(eval git_authorname ?= $(shell bash -c 'read -p  "Git config name: " name; echo $$name'))
	$(eval git_authoremail ?= $(shell bash -c 'read -p  "Git config email: " email; echo $$email'))
ifeq ($(shell uname -s),Darwin)
	git config -f ${HOME}/.gitconfig.local credential.helper osxkeychain
else
	git config -f ${HOME}/.gitconfig.local credential.helper cache
endif
	git config -f ${HOME}/.gitconfig.local user.name ${git_authorname}
	git config -f ${HOME}/.gitconfig.local user.email ${git_authoremail}


psqlrc:
	stow --targe ${HOME} psqlrc

wezterm:
	stow --targe ${HOME} wezterm

starship:
	stow --targe ${HOME} starship