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


.PHONY: brew zsh tmux vim git psqlrc sublime-text
all: brew zsh tmux vim git psqlrc sublime-text

brew:
	which brew || ruby -e ${HOMEBREW}
	brew tap homebrew/bundle
	brew bundle
	brew update


zsh:
	if [ ! -d ~/.oh-my-zsh/.git ]; then \
		git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh; \
	fi
	ln -sfv ${BASE_DIR}/.zshrc ${HOME}/.zshrc
	ln -sfv ${BASE_DIR}/zsh/custom ${HOME}/.zsh-custom
	mkdir -p ${HOME}/.zsh-custom/plugins
	cd ${HOME}/.zsh-custom/plugins/ && rm -rf zsh-syntax-highlighting && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
	cd ${HOME}/.zsh-custom/plugins/ && rm -rf zsh-completions && git clone https://github.com/zsh-users/zsh-completions
	cd ${HOME}/.zsh-custom/plugins/ && rm -rf zsh-history-substring-search && git clone https://github.com/zsh-users/zsh-history-substring-search.git

tmux:
	ln -sfv ${BASE_DIR}/.tmux.conf ${HOME}/.tmux.conf

vim:
	ln -snfv ${BASE_DIR}/vim ${HOME}/.vim

git:
	rm -f ${HOME}/.gitconfig.local
	ln -sfv ${BASE_DIR}/.gitconfig ${HOME}/.gitconfig
	ln -sfv ${BASE_DIR}/.gitignore ${HOME}/.gitignore
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
	ln -svf ${BASE_DIR}/.psqlrc ${HOME}/.psqlrc

sublime-text:
ifeq ($(shell uname -s),Darwin)
	ln -fs "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
endif


