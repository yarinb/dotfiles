setopt prompt_subst

export LSCOLORS=ExGxFxDxCxHxHxCbCeEbEb

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[blue]%}git%{$reset_color%}:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_BRANCH=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]?%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[cyan]%}%{+%G%}"

ZSH_THEME_HG_PROMPT_PREFIX=" on %{$fg[blue]%}hg%{$reset_color%}:"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[green]%}+"

ZSH_THEME_VIRTUALENV_PREFIX=" workon %{$fg[red]%}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%}"

ZSH_THEME_MULTIRUST_PREFIX=" rust %{$fg[magenta]%}"
ZSH_THEME_MULTIRUST_SUFFIX="%{$reset_color%}"

ZSH_THEME_PLANEINFO_TEMPLATE=" aboard %{$fg[cyan]%}:orig_airport%{$reset_color%}-%{$fg[yellow]%}:dst_airport%{$reset_color%} on %{$fg[magenta]%}:flight_number%{$reset_color%} eta %{$fg[green]%}T-:eta%{$reset_color%}%{$fg[red]%}:not_online_marker%{$reset_color%}"
ZSH_THEME_TRAININFO_TEMPLATE=" aboard %{$fg[magenta]%}:train_number%{$reset_color%} to %{$fg[cyan]%}:dst_station%{$reset_color%} eta %{$fg[green]%}T-:eta%{$reset_color%}%{$fg[red]%}:not_online_marker%{$reset_color%}"

# If iTerm is detected these themes are used for regular windows
# and ssh respectively
YARINB_ITERM_NORMAL_PROFILE='Fancy'
YARINB_ITERM_SSH_PROFILE='FancySSH'

# This is the basic prompt that is always printed.  It will be
# enclosed to make it newline.
_YARINB_PROMPT='%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg[green]%}%~%{$reset_color%}%'

# On iTerm we switch terminals for SSH if we have it.  This switches to
# the SSH profile and back when ssh is run from the terminal.
if [[ "$TERM_PROGRAM" == iTerm.app ]]; then
  function ssh() {
    echo -n -e $'\033]50;SetProfile='$YARINB_ITERM_SSH_PROFILE'\a'
    command ssh "$@"
    echo -n -e $'\033]50;SetProfile='$YARINB_ITERM_NORMAL_PROFILE'\a'
  }
fi

# This is the base prompt that is rendered sync.  It should be
# fast to render as a result.  The extra whitespace before the
# newline is necessary to avoid some rendering bugs.
PROMPT=$'\n'$_YARINB_PROMPT$' \n$ '
RPROMPT=''

# The pid of the async prompt process and the communication file
_YARINB_ASYNC_PROMPT=0
_YARINB_ASYNC_PROMPT_FN="/tmp/.zsh_tmp_prompt_$$"

# Remove the default git var update from chpwd and precmd to speed
# up the shell prompt.  We will do the precmd_update_git_vars in
# the async prompt instead
chpwd_functions=("${(@)chpwd_functions:#chpwd_update_git_vars}")
precmd_functions=("${(@)precmd_functions:#precmd_update_git_vars}")

# This here implements the async handling of the prompt.  It
# runs the expensive git parts in a subprocess and passes the
# information back via tempfile.
function _yarinb_precmd() {
  _yarinb_rv=$?

  function async_prompt() {
    # Run the git var update here instead of in the parent
    precmd_update_git_vars

    #
    echo -n $'\n'$_YARINB_PROMPT$' '$(git_super_status)$(virtualenv_prompt_info) > $_YARINB_ASYNC_PROMPT_FN
    if [[ x$_yarinb_rv != x0 ]]; then
      echo -n " exited %{$fg[red]%}$_yarinb_rv%{$reset_color%}" >> $_YARINB_ASYNC_PROMPT_FN
    fi
    echo -n $' \n$ ' >> $_YARINB_ASYNC_PROMPT_FN

    # signal parent
    kill -s USR1 $$
  }

  # If we still have a prompt async process we kill it to make sure
  # we do not backlog with useless prompt things.  This also makes
  # sure that we do not have prompts interleave in the tempfile.
  if [[ "${_YARINB_ASYNC_PROMPT}" != 0 ]]; then
    kill -s HUP $_YARINB_ASYNC_PROMPT >/dev/null 2>&1 || :
  fi

  # start background computation
  async_prompt &!
  _YARINB_ASYNC_PROMPT=$!
}

# This is the trap for the signal that updates our prompt and
# redraws it.  We intentionally do not delete the tempfile here
# so that we can reuse the last prompt for successive commands
function _yarinb_trapusr1() {
  PROMPT="$(cat $_YARINB_ASYNC_PROMPT_FN)"
  _YARINB_ASYNC_PROMPT=0
  zle && zle reset-prompt
}

# Make sure we clean up our tempfile on exit
function _yarinb_zshexit() {
  rm -f $_YARINB_ASYNC_PROMPT_FN
}

# Hook our precmd and zshexit functions and USR1 trap
precmd_functions+=(_yarinb_precmd)
zshexit_functions+=(_yarinb_zshexit)
trap '_yarinb_trapusr1' USR1

# vim: filetype=sh

