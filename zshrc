# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="mrchrisadams"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"
#
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx ruby gem cap brew ssh-agent)

source $ZSH/oh-my-zsh.sh

# Personal changes to shell as follows 
export EDITOR='mvim -f'

# set local paths for mysql et al
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"


function edit-unmerged () {
 mvim `git ls-files --unmerged | cut -f2 | sort -u`
}

function add-unmerged () {
 git add `git ls-files --unmerged | cut -f2 | sort -u`
}
# Fix for the weird ~rvm_rvmrc_cwd bug
# http://rvm.beginrescueend.com/integration/zsh/
unsetopt auto_name_dirs

# Add rvm to give us RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# Knife will often be intercepted by zsh's attempted corrections of filenames
alias knife='nocorrect knife'

