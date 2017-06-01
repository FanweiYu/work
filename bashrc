# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto -n'
    alias fgrep='fgrep --color=auto -n'
    alias egrep='egrep --color=auto -n'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
#alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
function git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
        echo "("${ref#refs/heads/}") ";
        }
function parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#add by Fanwei
export PS1="\[\e[1;31m\]\w\[\e[0;33m\]\$(parse_git_branch)\[\e[0m\$ "
#PS1="[\[\e[1;33m\]\u\[\e[1;37m\]@\[\e[1;32m\]\h\[\e[1;37m\]]:\[\e[1;31m\]\w\[\e[0;33m\]\$(parse_git_branch)\[\e[0m\$ "

#export PS1=$'\[\E[1;39m\](\A)\[\E[1;31m\]\[\E[0;39m\][\w]\[\E[0;39m\]\$\[\E[1;39m\] \[\033[0m\]'
#export PAGER='/usr/bin/less'
#export LESS_TERMCAP_mb=$'\E[01;31m'
#export LESS_TERMCAP_md=$'\E[01;31m'
#export LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_se=$'\E[0m'
#export LESS_TERMCAP_so=$'\E[01;44;33m'
#export LESS_TERMCAP_ue=$'\E[0m'
#export LESS_TERMCAP_us=$'\E[01;32m'
#alias l='ls -alhiFG --color=always'
#alias ls='ls -F --color=always'
#alias grep='grep --color=auto -n'

alias lgdb='libtool --mode=execute gdb'
#PATH=/bin:/usr/bin:/usr/lib/jvm/jdk1.6.0_45/bin:/usr/local/sbin:/usr/local/bin/home/:$PATH

# use the device gdb here
#export PATH=/home/mtk06481/android/android-ndk-r10b/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64/bin/:$PATH
#export PATH=/home/mtk06481/android/aarch64-linux-android-4.9/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/:$PATH
#export PATH=/home/mtk06481/android/bin/:$PATH
#export PATH=/home/mtk06481/android/android-ndk-r10b/:$PATH
#export PATH=/home/mtk06481/llvm/llvm.3.7.build/bin:$PATH
# Arcanist
#export PATH=/home/charmuser/phabricator/arcanist/bin:$PATH
#source /home/charmuser/phabricator/arcanist/resources/shell/bash-completion

export PATH=/proj/mtk06481/bin/:$PATH
export ANDROID_ADB_SERVER_PORT=16481
export GIT_SSL_NO_VERIFY=true
# clear duplicate path
export PATH=/mtkoss/git:$PATH
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++')

# export TERM for enabling 256 color
export TERM='xterm-256color'
# tmux
alias tmux="tmux -2"
make()
{
  pathpat="(/[^/]*)+:[0-9]+"
    ccred=$(echo -e "\033[0;31m")
    ccyellow=$(echo -e "\033[0;33m")
    ccend=$(echo -e "\033[0m")
    /usr/bin/make "$@" 2>&1 | sed -E -e "/[Ee]rror[: ]/ s%$pathpat%$ccred&$ccend%g" -e "/[Ww]arning[: ]/ s%$pathpat%$ccyellow&$ccend%g"
    return ${PIPESTATUS[0]}
}

function filegrep() {
  echo "find . -name \".repo\" -prune -o -name \".git\" -prune -o -name \".svn\" -prune -o -type f | egrep --color -n $@"
  find . -name ".repo" -prune -o -name ".git" -prune -o -name ".svn" -prune -o -type f | egrep --color -n "$@"
}

function srcgrep() {
  echo "egrep --color -n -I -r --exclude-dir=\".repo\" --exclude-dir=\".svn\" --exclude-dir=\".git\" ---exclude=\"Makefile.in\" -exclude=\"*.swp\" --exclude=\"tags\" $@ ./ 2> /dev/null"
  egrep -C 1 --color -n -I -r --exclude-dir=".repo" --exclude-dir=".svn" --exclude-dir=".git" --exclude="Makefile.in" --exclude="*.swp" --exclude="tags" "$@" ./ 2> /dev/null
}

#enable dircolor-solazried
eval `dircolors /proj/mtk06481/misc/dircolors-solarized/dircolors.256dark`

