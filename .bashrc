# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
HISTSIZE=-1
HISTFILESIZE=-1

LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
LESS=' -R '

# Aliases
alias f="find . -iname "
