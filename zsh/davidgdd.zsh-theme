# oh-my-zsh DavidGDD theme forked from Bureau Theme

### NVM: ⬡ x.x.x ·······································································································

ZSH_THEME_NVM_PROMPT_PREFIX="%{$fg_bold[green]%}%B⬡%b "
ZSH_THEME_NVM_PROMPT_SUFFIX=""

### GIT: [±master ▾●] ··································································································

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[red]%}⌥ %{$reset_color%}%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}>%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[red]%}<%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

getGitBranch () {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

getGitStatus() {
  _STATUS=""

  # check status of files
  _INDEX=$(command git status --porcelain 2> /dev/null)
  if [[ -n "$_INDEX" ]]; then
    if $(echo "$_INDEX" | command grep -q '^[AMRD]. '); then
      _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
    fi
    if $(echo "$_INDEX" | command grep -q '^.[MTD] '); then
      _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
    fi
    if $(echo "$_INDEX" | command grep -q -E '^\?\? '); then
      _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
    fi
    if $(echo "$_INDEX" | command grep -q '^UU '); then
      _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
    fi
  else
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi

  # check status of local repository
  _INDEX=$(command git status --porcelain -b 2> /dev/null)
  if $(echo "$_INDEX" | command grep -q '^## .*ahead'); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
  if $(echo "$_INDEX" | command grep -q '^## .*behind'); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi
  if $(echo "$_INDEX" | command grep -q '^## .*diverged'); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_DIVERGED"
  fi

  if $(command git rev-parse --verify refs/stash &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STASHED"
  fi

  echo $_STATUS
}

getGitPrompt () {
  local _branch=$(getGitBranch)
  local _status=$(getGitStatus)
  local _result=""
  if [[ "${_branch}x" != "x" ]]; then
    _result="$ZSH_THEME_GIT_PROMPT_PREFIX$_branch"
    if [[ "${_status}x" != "x" ]]; then
      _result="$_result $_status"
    fi
    _result="$_result$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
  echo $_result
}

########################################################################################################################

_PATH="%{$fg_bold[white]%}%~%{$reset_color%}"

_USER="%{$fg_bold[yellow]%}%n"
_LINK="%{$fg[white ]%}⇌ "
_HOST="%{$fg_bold[yellow]%}%m"

_WHERE="($_USER%{$reset_color%} $_LINK%{$reset_color%} $_HOST%{$reset_color%})"

_LIBERTY="%{$fg_bold[green]%}▸ "
_LIBERTY="$_LIBERTY%{$reset_color%}"

getSpace () {
  local STR=$1$2
  local zero='%([BSUbfksu]|([FB]|){*})'
  local LENGTH=${#${(S%%)STR//$~zero/}}
  local SPACES=""
  (( LENGTH = ${COLUMNS} - $LENGTH - 1))

  for i in {0..$LENGTH}
    do
      SPACES="$SPACES "
    done

  echo $SPACES
}

infoLine () {
  _LEFTinfo="$_WHERE $_PATH"
  _RIGHTinfo="[%*] "
  _SPACES=`getSpace $_LEFTinfo $_RIGHTinfo`
  print
  print -rP "$_LEFTinfo$_SPACES$_RIGHTinfo"
}

### JAVA: ☕x.x.x ·············································································································
getJavaVersion() {
  echo `java -version 2>&1 | awk -F '"' '/version/ {print $2}'`
}

java_info="%{$fg[blue]%}☕ %{$reset_color%}$(getJavaVersion)"

### PROMPT y PRECMD ····································································································
setopt prompt_subst
PROMPT='$_LIBERTY'
RPROMPT='${java_info} $(nvm_prompt_info) $(getGitPrompt)'

autoload -U add-zsh-hook
add-zsh-hook precmd infoLine
