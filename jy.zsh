#!/usr/local/bin/zsh
export PATH=$PATH:/usr/local/bin

alias less='less -F -X'
alias ftree='tree -ACF --dirsfirst'
alias httpstat='python3 /Users/jiangyu/github/httpstat/httpstat.py'

export IT=10.0.64.56
alias ej="vim ~/.env/jy.zsh"
alias zz="source ~/.env/jy.zsh"

alias it='ssh -o SendEnv=LC_NAME -l root 10.0.64.56'
alias it.new='ssh -o SendEnv=LC_NAME -l root 10.0.64.6'

alias master='git cd master'
alias develop='git cd develop'
alias us='git cd release-us'
alias tw='git cd release-tw'
alias th='git cd release-th'
alias vz='git cd release-vz'
alias gdmf='git --no-pager diff --stat master'

alias en="cdi us en_US"
alias am="cdi us am"
alias de="cdi us de-DE"

alias svn_watch='tcpdump -i en4 -s 0 -l -w - "dst host 10.0.64.7 and port 80" | strings'

alias cdlog='cd /mnt/htdocs/logs/'

localip()
{
    ifconfig | ack "inet " | grep -v -e "127.0.0.1" | awk '{print $2}'
}
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
    php -r "define('SYS_PATH', 1); \$filename=dirname('$file').'/'.basename('$file', '.php').'.php'; require '/mnt/htdocs/farm/vendor/autoload.php'; dump(require \$filename); dump(\$filename); "
}
pstore()
{
    pdump "/mnt/htdocs/dev3/farm/data/i18n/en_US/store/$1.php"
}
pstory()
{
    pdump "/mnt/htdocs/dev3/farm/data/i18n/en_US/story/$1.php"
}
pconfig()
{
    pdump "/mnt/htdocs/dev3/farm/data/config/$1"
}
plang()
{
    pdump "/mnt/htdocs/dev3/farm/data/i18n/en_US/$1.php"
}
entity()
{
    if [ $# -ne 1 ]; then
        echo "Usage: ${FUNCNAME[0]} {store id}"
        return
    fi
    php /mnt/htdocs/tools/application/DataViz/Store/entity.php --id $1
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
cdc()
{
    if [ $# -eq 0 ]; then
        cd /mnt/htdocs/compile
        return
    fi

    cdd $1 || return
    cd compile || return
}
cdf()
{
    if [ $# -eq 0 ]; then
        cd /mnt/htdocs/FacebookData
        return
    fi

    cdd $1 || return
    cd FacebookData || return
}
cdg()
{
    if [ $# -eq 0 ]; then
        cd /mnt/htdocs/farm
        return
    fi

    cdd $1 || return
    cd farm || return
}
cdt()
{
    if [ $# -eq 0 ]; then
        cd /mnt/htdocs/tools
        return
    fi

    cdd $1 || return
    cd tools || return
}
cdp()
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
cdi()
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
alias fssh="ssh -F /Users/jiangyu/.ssh/vpc_config"
fscp()
{
    cmd="scp -F /Users/jiangyu/.ssh/vpc_config $*"
    green "$cmd"
    eval "$cmd"
}
countweb()
{
    if [ $# -eq 0 ]; then
        red "Usage: ${FUNCNAME[0]} <version> [sync]"
        return;
    fi
    local version=$1
    local localFile="/Users/jiangyu/web_array/$version.array"
    if [ $# -eq 2 ]; then
        local remoteFile="$version.tools:/etc/haproxy/conf.d/haproxy_array.cfg"
        local cmd="fscp $remoteFile $localFile"
        #green $cmd
        if ! eval "$cmd"
            then
            red "$cmd failed"
            return
        fi
    fi
    grep -v -e 127.0.0.1 "$localFile" | grep server | awk 'BEGIN{num=0}{num=num+1; print $2;}END{print "total="num}'
}
upcode()
{
    local entry
    entry=$(pwd)
    cdg
    blue "$(pwd)"
    for branch in release-vz release-tw release-th release-us develop master
    do
        if ! git checkout $branch
            then
            red "$branch not exist"
            return
        fi
        if ! git pull --rebase
            then
            red "$branch git pull failed"
            return
        fi
    done

    cdt
    blue "$(pwd)"
    if ! git pull --rebase
        then
        red "tools git pull failed"
    fi

    cdc
    blue "$(pwd)"
    if ! git pull --rebase
        then
        red "compile git pull failed"
    fi

    cd "$entry" || die "$entry not exist anymore"
}
alias cdcfg="cd /mnt/htdocs/farm-server-conf"
alias cdfr="cd /mnt/htdocs/dev2/static/farm-release"
cdfs()
{
	cd /mnt/htdocs/dev2/static/farm-static || return
	if [[ $# -eq 0 ]]; then
		return
	fi
	if [[ ! -d "static_fb_$1" ]]; then
		die "bad input $1"
	fi

	cd "static_fb_$1" || die "bad input"
}
cdfsg()
{
	cd /mnt/htdocs/dev5/static/farm-static-sg || return
	if [[ $# -eq 0 ]]; then
		return
	fi
	if [[ ! -d "static_sg_$1" ]]; then
		die "bad input $1"
	fi
	cd "static_sg_$1" || die "bad input"
}
getAllHost()
{
    cmd="ssh vpc php /mnt/deploy/gethost.php > /mnt/htdocs/vpc/host.cache"
    green "$cmd"
    eval "$cmd"
}
gethost()
{
    gv=$1
    type=$2
    if [ ! -f /mnt/htdocs/vpc/host.cache ]; then
      getAllHost
  fi
  grep farm-$gv-$type /mnt/htdocs/vpc/host.cache | awk -F ',' '{print $2}'
}
code_status()
{
    git branch -vv --list "release*" master develop
}
uid()
{
	php /mnt/htdocs/farm/cli/user.php --snsid $1
}
snsid()
{
	php /mnt/htdocs/farm/cli/user.php --uid $1
}
logserver()
{
	if [ $# -ne 1 ]; then
		die "Usage: $FUNCNAME <gameVersion>"
	fi
	host=$(fssh $1.tools "grep endpoints /etc/td-agent/config.d/farm.conf" | awk '{print $2}' | sed 's/ //g' | sed 's/:64431//g' | sort | uniq | awk -F ',' '{print $1}')
	green $host
	#fssh $host
}
json()
{
    node -e "process.stdin.on('data', function(str) { console.log(JSON.parse(str)); }); "
}

notif_check() {
    local hosts=$(for gv in tw th br de it fr us pl nl; do gethost $gv notif; done)
    for host in 10.15.8.41 10.14.8.157 10.10.8.66
    do
        echo $host
        fssh $host "cd /mnt/htdocs/farm-server-conf; git pull && git log --color --graph --pretty=format:'%C(bold blue)%h%Creset %Cgreen(%cr) -%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset' --abbrev-commit -n 1"
    done        
}
pcompile() {
	cdc
	php workflow.php --work works/compileLang.php --lang en_US
}