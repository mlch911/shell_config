export PATH=$HOME/bin:/usr/local/bin:$PATH:/usr/local/sbin

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Antigen: https://github.com/zsh-users/antigen
ANTIGEN="$HOME/.local/bin/antigen.zsh"

# Install antigen.zsh if not exist
if [ ! -f "$ANTIGEN" ]; then
	echo "Installing antigen ..."
	[ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
	[ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
	[ ! -f "$HOME/.z" ] && touch "$HOME/.z"
	URL="http://git.io/antigen"
	TMPFILE="/tmp/antigen.zsh"
	if [ -x "$(which curl)" ]; then
		curl -L "$URL" -o "$TMPFILE"
	elif [ -x "$(which wget)" ]; then
		wget "$URL" -O "$TMPFILE"
	else
		echo "ERROR: please install curl or wget before installation !!"
		exit
	fi
	if [ ! $? -eq 0 ]; then
		echo ""
		echo "ERROR: downloading antigen.zsh ($URL) failed !!"
		exit
	fi;
	echo "move $TMPFILE to $ANTIGEN"
	mv "$TMPFILE" "$ANTIGEN"
fi


# Initialize command prompt
export PS1="%n@%m:%~%# "

# Enable 256 color to make auto-suggestions look nice
export TERM="xterm-256color"


# Load local bash/zsh compatible settings
_INIT_SH_NOFUN=1
[ -f "$HOME/.local/etc/init.sh" ] && source "$HOME/.local/etc/init.sh"

# exit for non-interactive shell
[[ $- != *i* ]] && return

# WSL (aka Bash for Windows) doesn't work well with BG_NICE
[ -d "/mnt/c" ] && [[ "$(uname -a)" == *Microsoft* ]] && unsetopt BG_NICE


# Initialize antigen
source "$ANTIGEN"


# Initialize oh-my-zsh
antigen use oh-my-zsh

# default bundles
# visit https://github.com/unixorn/awesome-zsh-plugins
antigen bundle git
antigen bundle npm
# antigen bundle heroku
antigen bundle pip
antigen bundle svn-fast-info
antigen bundle command-not-find
antigen bundle pod
antigen bundle colorize
antigen bundle github
antigen bundle python
antigen bundle rupa/z z.sh
antigen bundle z
antigen bundle sudo
antigen bundle safe-paste
antigen bundle colored-man-pages
antigen bundle history-substring-search
antigen bundle gem
antigen bundle ruby
antigen bundle node

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
# antigen bundle supercrabtree/k
antigen bundle Vifon/deer
antigen bundle valentinocossar/vscode

antigen bundle zsh-users/zaw

# uncomment the line below to enable theme
# antigen theme agnoster
POWERLEVEL9K_MODE="nerdfont-complete"
antigen theme romkatv/powerlevel10k

# enable syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply


# check login shell
if [[ -o login ]]; then
	[ -f "$HOME/.local/etc/login.sh" ] && source "$HOME/.local/etc/login.sh"
	[ -f "$HOME/.local/etc/login.zsh" ] && source "$HOME/.local/etc/login.zsh"
fi

# syntax color definition
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -A ZSH_HIGHLIGHT_STYLES

# ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
# ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'

ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none

# load local config
[ -f "$HOME/.local/etc/config.zsh" ] && source "$HOME/.local/etc/config.zsh"
[ -f "$HOME/.local/etc/local.zsh" ] && source "$HOME/.local/etc/local.zsh"

# setup for deer
autoload -U deer
zle -N deer

# default keymap
bindkey -s '\ee' 'vim\n'
bindkey '\eh' backward-char
bindkey '\el' forward-char
bindkey '\ej' down-line-or-history
bindkey '\ek' up-line-or-history
# bindkey '\eu' undo
bindkey '\eH' backward-word
bindkey '\eL' forward-word
bindkey '\eJ' beginning-of-line
bindkey '\eK' end-of-line

bindkey -s '\eo' 'cd ..\n'
bindkey -s '\el' 'ls -g\n'

bindkey '\e[1;3D' backward-word
bindkey '\e[1;3C' forward-word
bindkey '\e[1;3A' beginning-of-line
bindkey '\e[1;3B' end-of-line

bindkey '^k' deer

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down


# options
unsetopt correct_all

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY # Don't execute immediately upon history expansion.
setopt no_nomatch				# Remove error: zsh: no matches found


# source function.sh if it exists
[ -f "$HOME/.local/etc/function.sh" ] && . "$HOME/.local/etc/function.sh"


# ignore complition
zstyle ':completion:*:complete:-command-:*:*' ignored-patterns '*.pdf|*.exe|*.dll'
zstyle ':completion:*:*sh:*:' tag-order files

# Hide the “user@hostname” info when you’re logged in as yourself on your local machine.
DEFAULT_USER="mlch911"

# Disable update prompt and update silently
disable_update_prompt="true"

# auto-fu
if [ ! -d ~/.oh-my-zsh/custom/plugins ]; then
	mkdir ~/.oh-my-zsh/custom/plugins
	git clone https://github.com/hchbaw/auto-fu.zsh.git ~/.oh-my-zsh/custom/plugins/auto-fu
	sh -c 'A=~/.oh-my-zsh/custom/plugins/auto-fu/auto-fu.zsh; (zsh -c "source $A ; auto-fu-zcompile $A ~/.zsh")'
fi
{ . ~/.zsh/auto-fu; auto-fu-install; }
zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=black,bold
zstyle ':auto-fu:var' postdisplay $'\n-azfu-'
zle-line-init () {auto-fu-init;}; zle -N zle-line-init
zstyle ':auto-fu:var' autoable-function/skiplbuffers 'gem install*'

#alias
alias ls='colorls'
alias lc='ls -l --sd --gs'
alias ll='lc'
alias lll='ls -lA --sd --gs'
alias mtr='sudo mtr'
alias myip='curl www.trackip.net/ip'
alias vim='nvim'
alias v='vim'
alias vd=VimDirectory
alias ra='ranger'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[ -f "$HOME/.rvm/bin" ] && export PATH="$PATH:$HOME/.rvm/bin"
[ -f "/etc/profile.d/rvm.sh" ] && source /etc/profile.d/rvm.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Git
export GIT_EDITOR=vim

# machine_specific
[ -f "$HOME/.config/config/.zshrc_machine_specific" ] && source "$HOME/.config/config/.zshrc_machine_specific"
[ -f "$HOME/.zshrc_machine_specific" ] && source "$HOME/.zshrc_machine_specific"

VimDirectory() {
	dir=$(echo $1 | grep -oP '.*(?=\/.*$)')
	if [ ! -f $dir ]; then
		mkdir -p $dir
	fi
	vim $1
}
