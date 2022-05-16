### Vim Default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

### DOWNLOAD POWERLEVEL10K
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

### CONTENT GENERATED BELOW AFTER RUNNING P10K CONFIGURE

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
bindkey -v

# Basic auto/tab complete:
#autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
#compinit
_comp_options+=(globdots)		# Include hidden files.

# Git auto/tab complete only for Git
cd ~/.zsh
curl -o _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
echo "zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.zsh" >> ~/.zshrc
echo 'fpath=(~/.zsh $fpath)'  >> ~/.zshrc

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/marc/.zshrc'
zstyle :compinstall filename "~/.zshrc"

autoload -Uz compinit && compinit

### DOCKER AUTO-COMPLETION COMMANDS ACTIVATION
# make sure the "_docker" file from  https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker  is installed under /usr/share/zsh/site-functions

### DOCKER CONTENT BELOW NEEDS TO BE ADDED TO ALLOW DOCKER AUTO-COMPLETION COMMAND
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
source ~/powerlevel10k/powerlevel10k.zsh-theme



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export EDITOR="/usr/bin/vim" # define Vim as the editor by default
export PATH="$PATH:/root/.local/bin"


setopt appendhistory
# User specific aliases and functions

##########EXTRA INFO##########
########To disable an alias, add "\" before the alias####
##########EXTRA INFO##########
alias ll="ls -alh"
alias history="history 1"
alias h="history"
alias mv="mv -iv"
alias cp="cp -iv"
alias rm="rm -iv"
alias df="df -h"
alias du="du -h"
alias mkdir="mkdir -p"
alias diffy="diff -y --suppress-common-lines --width=250"
alias gpa="git-pull-all"
alias untar="tar -zxvf"
alias c="clear"
alias vim="nvim"

#Want to download something but be able to resume if something goes wrong?
alias wget="wget -c"

#Need to generate a random, 20-character password for a new online account?
alias getpass="openssl rand -base64 20"

#Downloaded a file and need to test the checksum?
alias sha="shasum -a 256"

#Start a web server in any folder you"d like
alias www="python -m SimpleHTTPServer 8000"

#####NETWORK
###speed test
alias speed="speedtest-cli --server XYZ --simple"

#Need to know your local IP address?
alias ip="curl ipinfo.io/ip/"

#Show open ports
alias ports="netstat -tulanp"

#limit to 5 pings.
alias ping="ping -c 5"

# Do not wait interval 1 second, go fast #
alias fastping="ping -c 100 -s.2"

#Clear the screen
alias c="clear"

#Colorize the grep command output for ease of use (good for log files)
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# install  colordiff package :)
alias diff="colordiff"

# handy short cuts #
alias h="history"
alias j="jobs -l"


################### FIREWALL ###################
## shortcut  for iptables and pass it via sudo #
alias ipt="sudo /sbin/iptables"
 
# display all rules #
alias iptlist="sudo /sbin/iptables -L -n -v --line-numbers"
alias iptlistin="sudo /sbin/iptables -L INPUT -n -v --line-numbers"
alias iptlistout="sudo /sbin/iptables -L OUTPUT -n -v --line-numbers"
alias iptlistfw="sudo /sbin/iptables -L FORWARD -n -v --line-numbers"
alias firewall=iptlist

####### Get system memory, cpu usage, and gpu memory info quickly

## pass options to free ##
alias meminfo="free -m -l -t"
 
## get top process eating memory
alias psmem="ps auxf | sort -nr -k 4"
alias psmem10="ps auxf | sort -nr -k 4 | head -10"
 
## get top process eating cpu ##
alias pscpu="ps auxf | sort -nr -k 3"
alias pscpu10="ps auxf | sort -nr -k 3 | head -10"
 
## Get server cpu info ##
alias cpuinfo="lscpu"
 
## older system use /proc/cpuinfo ##
##alias cpuinfo="less /proc/cpuinfo" ##
 
## get GPU ram on desktop / laptop##
alias gpumeminfo="grep -i --color memory /var/log/Xorg.0.log"

## Size folder
alias size="du -sh"

## Replace ls by exa
alias ls="exa"
alias ll="exa -1 -F -l -a --git -g -h"

#-------------------------------------------------------------
# Git Alias Commands
#-------------------------------------------------------------
alias gst="git status"
alias ga="git add"
alias gaa="git add ."
alias gau="git add -u"
alias gci="git commit -m"
alias gca="git commit -am"
alias gbr="git branch"
alias gbd="git branch -d"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gt="git stash"
alias gta="git stash apply"
alias gm="git merge"
alias gr="git rebase"
alias gl="git log --oneline --decorate --graph"
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias glga="git log --graph --oneline --all --decorate"
alias gb="git branch"
alias gs="git show"
alias gd="diff --color --color-words --abbrev"
alias gdc="git diff --cached"
alias gbl="git blame"
alias gps="git push"
alias gpl="git pull"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias go="git checkout "
alias gk="gitk --all&"
alias gx="gitx --all"
alias ghist="log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short"
alias gtype="cat-file -t"
alias gdump="cat-file -p"

# show ignored files by git
alias gx="ign = ls-files -o -i --exclude-standard"

# Untrack Files without deleting them
alias grmc="git rm -r --cached"

