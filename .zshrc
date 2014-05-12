#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# # Colors
# #Color table from: http://www.understudy.net/custom.html
# fg_black=%{$'\e[0;30m'%}
# fg_red=%{$'\e[0;31m'%}
# fg_green=%{$'\e[0;32m'%}
# fg_brown=%{$'\e[0;33m'%}
# fg_blue=%{$'\e[0;34m'%}
# fg_purple=%{$'\e[0;35m'%}
# fg_cyan=%{$'\e[0;36m'%}
# fg_lgray=%{$'\e[0;37m'%}
# fg_dgray=%{$'\e[1;30m'%}
# fg_lred=%{$'\e[1;31m'%}
# fg_lgreen=%{$'\e[1;32m'%}
# fg_yellow=%{$'\e[1;33m'%}
# fg_lblue=%{$'\e[1;34m'%}
# fg_pink=%{$'\e[1;35m'%}
# fg_lcyan=%{$'\e[1;36m'%}
# fg_white=%{$'\e[1;37m'%}
# #Text Background Colors
# bg_red=%{$'\e[0;41m'%}
# bg_green=%{$'\e[0;42m'%}
# bg_brown=%{$'\e[0;43m'%}
# bg_blue=%{$'\e[0;44m'%}
# bg_purple=%{$'\e[0;45m'%}
# bg_cyan=%{$'\e[0;46m'%}
# bg_gray=%{$'\e[0;47m'%}
# #Attributes
# at_normal=%{$'\e[0m'%}
# at_bold=%{$'\e[1m'%}
# at_italics=%{$'\e[3m'%}
# at_underl=%{$'\e[4m'%}
# at_blink=%{$'\e[5m'%}
# at_outline=%{$'\e[6m'%}
# at_reverse=%{$'\e[7m'%}
# at_nondisp=%{$'\e[8m'%}
# at_strike=%{$'\e[9m'%}
# at_boldoff=%{$'\e[22m'%}
# at_italicsoff=%{$'\e[23m'%}
# at_underloff=%{$'\e[24m'%}
# at_blinkoff=%{$'\e[25m'%}
# at_reverseoff=%{$'\e[27m'%}
# at_strikeoff=%{$'\e[29m'%}

export EDITOR='subl -w'

export PATH="$PATH:/usr/local/bin/"
export PATH="/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/local/git/bin:/Users/kunsang/.scripts:/usr/local/mysql/bin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


# init z   https://github.com/rupa/z
. ~/.scripts/z/z.sh

# throw a file on my server and pbcopy the link

function scpp() {
	scp "$1" fuckup@auriga.uberspace.de:~/html/i;
	echo "http://fuckup.auriga.uberspace.de/i/$1" | pbcopy;
	echo "Copied to pasteboard: http://fuckup.auriga.uberspace.de/i/$1"
}

function cdf() {  # short for cdfinder
  cd `osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`
  }

sman() {
	man "${1}" | col -b | open -f -a /Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text
}

# SSH Servers

alias rds='ssh -p 9584 kunsang@rockdenshit.de'
alias fuckup='ssh fuckup@auriga.uberspace.de'
alias oli='ssh -p 9584 kunsang@91.250.119.8'

# Custom OSX Aliases

alias .z='vim ~/.zshrc'
alias .a='vim ~/.aliases.sh'

alias m='~/.scripts/./memfree.py'
alias p='sudo purge && ~/.scripts/./memfree.py'

alias pb='pbpaste|pbcopy'

alias s="subl"
alias cask="brew cask install"




alias editchrome="s ~/.DevTools/hax/Custom.css"
alias editcanary="s ~/.DevTools/chrome-devtools-zerodarkmatrix-theme/canary-theme-extension/styles.css"

alias hide='sudo chflags hidden'
alias unhide='sudo chflags nohidden'

# Git Aliases

alias hist="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"

#alias dashOn='defaults write com.apple.dashboard mcx-disabled -boolean NO && killall Dock'
#alias dashOff='defaults write com.apple.dashboard mcx-disabled -boolean YES && killall Dock'

alias dockL="defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}' && killall Dock"
alias dockR="defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}' && killall Dock"

alias kf='killall Finder'

alias hf='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'
alias sf='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'

#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ls='ls -GFha'                         # Preferred 'ls' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias edit='subl'                           # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir

#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flush='dscacheutil -flushcache'            	# flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------

ii() {
	echo -e "\nYou are logged on ${RED}$HOST"
	echo -e "\nAdditionnal information:$NC " ; uname -a
	echo -e "\n${RED}Users logged on:$NC " ; w -h
	echo -e "\n${RED}Current date :$NC " ; date
	echo -e "\n${RED}Machine stats :$NC " ; uptime
	echo -e "\n${RED}Current network location :$NC " ; scselect
	echo -e "\n${RED}Public facing IP Address :$NC " ;myip
	#echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
	echo
}

#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

# Repair Permissions

alias repair="diskutil repairPermissions /"


alias mountRW='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------

alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
#    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
#    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------

alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------

alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#   ---------------------------------------
#   8.  WEB DEVELOPMENT
#   ---------------------------------------

alias aped='sudo s /etc/apache2/httpd.conf'      # apacheEdit:       Edit httpd.conf
alias apres='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias hosts='sudo subl /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/apache2/error_log'              # herr:             Tails HTTP error logs
alias aplogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------

httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

# Source: http://aur.archlinux.org/packages/lolbash/lolbash/lolbash.sh

alias wtf='sudo dmesg'
alias onoz='cat /var/log/system.log'
alias rtfm='man'
alias visible='echo'
alias invisible='cat'
alias moar='more'
alias icanhas='mkdir'
alias donotwant='rm'
alias dowant='cp'
alias gtfo='mv'
alias hai='cd'
alias plz='pwd'
alias inur='locate'
alias nomz='ps aux | less'
alias nomnom='killall'
alias cya='reboot'
alias kthxbai='halt'
gimme () { brew update && brew install "$1"; }
