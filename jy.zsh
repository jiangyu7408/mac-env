#!/usr/local/bin/zsh

alias httpstat='python3 /Users/jiangyu/github/httpstat/httpstat.py'

export IT=10.0.64.56
alias ej="atom-beta ~/.env/jy.zsh"
alias zz="source ~/.env/jy.zsh"

alias it='ssh -o SendEnv=LC_NAME -l root 10.0.64.56'
alias it.new='ssh -o SendEnv=LC_NAME -l root 10.0.64.6'

alias gs='git status -s'

blue()
{
    echo -e "\x1b[34m\x1b[1m\"$*\"\x1b[0m"
}
green()
{
    echo -e "\x1b[32m\x1b[1m\"$*\"\x1b[0m"
}
red()
{
    echo -e "\x1b[31m\x1b[1m\"$*\"\x1b[0m"
}
die()
{
    red "$*"
    return 2
}
push_to_local()
{
    if [ $# -eq 1 ]; then
        file=$1
        cmd="scp ${file} root@$IT:~/"
        green "$cmd"
        eval "$cmd"
    else
        red "Usage: ${FUNCNAME[0]} <file>"
    fi
}
pull_from_local()
{
    if [ $# -eq 1 ]; then
        file=$1
        cmd="scp root@$IT:${file} ."
        green "$cmd"
        eval "$cmd"
    else
        red "Usage: ${FUNCNAME[0]} <file>"
    fi
}
pdump()
{
    if [ $# -eq 0 ]; then
        echo "Usage: ${FUNCNAME[0]} <filename>"
        return
    fi
    file=$1
    php -r "require '/mnt/htdocs/farm/vendor/autoload.php'; dump(require '$file');"
}
cgrep()
{
    if [ $# -ne 1 ]; then
        red "Usage: ${FUNCNAME[0]} <ack pattern>"
        return;
    fi
    for dir in /mnt/htdocs/farm/application/ /mnt/htdocs/farm/v2/ /mnt/htdocs/farm/libraries/ /mnt/htdocs/farm/public/ /mnt/htdocs/tools/ /mnt/htdocs/compile
    do
        ack "$1" $dir
    done
}

cds()
{
    if [ $# -ne 1 ]; then
        red "Usage $FUNCNAME <gameVersion>"
        return 1
    fi
    cdd $1
    cd static || return
}
cdd()
{
    if [ $# -ne 1 ]; then
        red "Usage $FUNCNAME <gameVersion>"
        return 1
    fi
    cd /mnt/htdocs || return
    if [ -d "dev$1" ]; then
        cd "dev$1"
        return 0
    fi
    if [ -d "dev-$1" ]; then
        cd "dev-$1"
        return 0
    fi
    red "game version not exist"
    return 1
}
function cdc()
{
    if [ $# -eq 0 ]; then
        cd /mnt/htdocs/compile
        return
    fi

    cdd $1 || return
    cd compile || return
}
function cdf()
{
    if [ $# -eq 0 ]; then
        cd /mnt/htdocs/FacebookData
        return
    fi

    cdd $1 || return
    cd FacebookData || return
}
function cdg()
{
    if [ $# -eq 0 ]; then
        cd /mnt/htdocs/farm
        return
    fi

    cdd $1 || return
    cd farm || return
}
function cdt()
{
    if [ $# -eq 0 ]; then
        cd /mnt/htdocs/tools
        return
    fi

    cdd $1 || return
    cd tools || return
}
function cdp()
{
    if [ $# -ne 2 ]; then
        red "Usage: $FUNCNAME <gameVersion> <lang>"
        return
    fi

    cdd $1 || return
    cd farm/data/i18n || return
    if [ ! -d $2 ]; then
        red "$2 not exist"
        return
    fi

    cd "$2"
}
function cdi()
{
    if [[ $# -eq 0 ]]; then
        red "Usage: ${FUNCNAME[0]} <gameVersion> <lang>"
        return
    fi
    local gv
    local lang
    if [ $# -eq 1 ]; then
        gv=3
        lang=$1
    fi
    if [ $# -eq 2 ]; then
        gv=$1
        lang=$2
    fi
    cdd $gv || return
    cd farm/data/i18n
    if [ ! -d $lang ]; then
        red "$lang not exist"
        return
    fi

    cd "$lang"
}
alias en="cdi us en_US"
alias am="cdi us am"
alias de="cdi us de-DE"
