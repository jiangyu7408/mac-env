#!/bin/bash

function blue()
{
    echo -e "\x1b[34m\x1b[1m\"$*\"\x1b[0m"
}
function green()
{
    echo -e "\x1b[32m\x1b[1m\"$*\"\x1b[0m"
}
function red()
{
    echo -e "\x1b[31m\x1b[1m\"$*\"\x1b[0m"
}

alias xon="export XDEBUG_CONFIG=\"profiler_enable=1\""
alias xoff="export XDEBUG_CONFIG=\"profiler_enable=0\""
alias httpstat="python3 /Users/jiangyu/github/httpstat/httpstat.py"

alias php53='/usr/local/opt/php53/bin/php'
alias php55='/usr/local/opt/php55/bin/php'
alias php70='/usr/local/Cellar/php70/7.0.0-rc.6/bin/php'
alias phpmt='phpmetrics --report-cli'
alias phpunit='vendor/bin/phpunit --color=auto --verbose --stop-on-error --stop-on-failure'
alias puv='phpunit --bootstrap /mnt/htdocs/farm/tests/phpunit/tests/autoload.php'
alias pa='phpunit --bootstrap tests/phpunit/tests/autoload.php'
alias phpcsf='php-cs-fixer --level=symfony --fixers=-empty_return --verbose fix'

java_home='/usr/libexec/java_home'
export java_home
alias cdj='cd "$java_home"'
alias state='top -l 1 -n 0'
alias free="top -l 1 -n 0 | grep -e PhysMem -e unused"
function die()
{
    red "$*"
    return 2
}
function ips()
{
    ifconfig -a | grep netmask | awk '{print $2}'
}
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias hardware='/usr/sbin/system_profiler -detailLevel full SPHardwareDataType'

alias lsf='find . -maxdepth 1 -type f'
alias lsl='find . -maxdepth 1 -type l'
alias lsd='find . -maxdepth 1 -type d'
export IT=10.0.64.56
alias it='ssh -o SendEnv=LC_NAME -l root 10.0.64.56'
alias it.new='ssh -o SendEnv=LC_NAME -l root 10.0.64.6'
alias it.bak='ssh -o SendEnv=LC_NAME -l root 10.0.64.80'

function show_svn_error()
{
    if [ $# -ne 1 ]; then
        red "Usage: $FUNCNAME <sha1>"
        return
    fi
    SHA1="$1"

    FILE=$(sqlite3 .svn/wc.db 'select local_relpath from nodes where checksum="$sha1$'$SHA1'"')
    echo "File causing trouble is: $FILE";
}

function push_to_local()
{
    if [ $# -eq 1 ]; then
        file=$1
        cmd="scp ${file} root@$IT:~/"
        green "$cmd"
        $cmd
    else
        red "Usage: ${FUNCNAME[0]} <file>"
    fi
}
export -f push_to_local

function pull_from_local()
{
    if [ $# -eq 1 ]; then
        file=$1
        cmd="scp root@$IT:${file} ."
        green "$cmd"
        $cmd
    else
        red "Usage: ${FUNCNAME[0]} <file>"
    fi
}
export -f pull_from_local

function md5check()
{
    flag=$1
    calculated=$(md5 "$2" | awk '{print "$4"}')
    green "$flag"
    blue "$calculated"
    if [[ "$calculated" = "$flag" ]]; then
        green "OK"
    else
        red "FAIL"
    fi
}

function bak()
{
    cmd="cp /Users/jiangyu/.bash_profile /Users/jiangyu/Dropbox/SystemConfig/mac.bash_profile"
    green "$cmd"
    $cmd
    cmd="cp /Users/jiangyu/.ssh/* /Users/jiangyu/Dropbox/SystemConfig/ssh_config/"
    green "$cmd"
    $cmd
    cmd="cp /Users/jiangyu/.vimrc /Users/jiangyu/Dropbox/SystemConfig/mac.vimrc"
    green "$cmd"
    $cmd
    cmd="scp root@10.0.64.56:~/.env/jy.sh /Users/jiangyu/Dropbox/SystemConfig/local.bash_profile"
    green "$cmd"
    $cmd
    cmd="scp root@10.0.64.56:~/.env/jy.zsh /Users/jiangyu/Dropbox/SystemConfig/local.zsh_profile"
    green "$cmd"
    eval "$cmd"
    cmd="scp root@10.0.64.56:~/.env/*.sh /Users/jiangyu/Dropbox/SystemConfig/local.env/"
    green "$cmd"
    $cmd
}

alias ascii='man 7 ascii'
alias tcpp='lsof -i -n -P | grep TCP'
alias mate='/usr/local/bin/mate'
alias grep='/usr/bin/grep --color=auto'
alias egrep='egrep --color=auto'
alias ssh='ssh -4'
alias ls='ls -G'
alias dir='ls -l | grep "^d"'
alias l='ls -l'
alias ll='ls -la'
alias mdfindin='mdfind -onlyin'
alias timestamp='date +%s'
alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
alias jsondecode='node -e "console.log(JSON.parse(process.argv[1]))"'

export VPC="10.13.0.100"
export CRS="52.74.58.152"
alias dbproxy="ssh -i ~/.ssh/farm-db-proxy.pem centos@10.0.74.96"

alias cpz='cp /dev/null'

alias gb='git branch'
alias git-find-commit='git branch --contain '
alias gbd='git push --delete origin'
alias gbu='git push -u origin'
alias gba='gb -avv'
alias gs='git status -s'
alias gcd='git checkout'
alias gp='git pull --rebase'
alias gl='git log --date=iso --abbrev-commit'
alias gls='gl --stat'
alias gignore="git ls-files --others --exclude-from=.git/info/exclude | grep -v -e '^vendor/' -e '^libraries/bi' -e '^build/' -e '^data/'"
alias glo='gl --pretty=oneline'
alias glos='glo --stat'
alias glfc='gl --pretty=format:"%h | %p | %an | %ar | %cd | %s"'
alias gd='git diff --color=auto --ignore-all-space --word-diff=none --ignore-space-at-eol --ignore-space-change --ignore-blank-lines'
alias gdd='gd develop..'
alias gdtw='gd release-tw..'
alias gdm='gd master..'
alias gdmf='gdm --stat'
alias gss='git show --stat --color=auto'
alias git-commit-summary='git shortlog --numbered --summary'
alias gr='git remote -v show -n origin | grep URL'
alias grv='git remote -v show origin'
alias master='gcd master'
alias develop='gcd develop'
alias map='gcd feature/mapEngine'

function gu()
{
    local entry
    entry=$(pwd)
    cd /mnt/htdocs/farm || die "/mnt/htdocs/farm not exist"
    for branch in master develop release-th release-tw release-us release-vz
    do
        git checkout $branch
        git pull
    done
    git checkout master || die "master branch not found"
    cd "$entry" || die "$entry not exist anymore"
}

function gm()
{
    git status -s | grep -v -e "??" | awk '{print $1 "\t" $2}'
}

EXCLUDE_CODE_DIR="--exclude-dir build \
    --exclude-dir public/js \
    --exclude-dir modules \
    --exclude-dir libraries \
    --exclude-dir coverage \
    --exclude-dir vendor \
    --exclude-dir cli \
    --exclude-dir geoip \
    --exclude-dir nbproject \
    --exclude-dir data\/cache \
    --exclude-dir data\/i18n \
    --exclude-dir data\/platforms \
    --exclude-dir libraries/osapi \
    --exclude-dir v2/third-party \
    --exclude *.orig"
export EXCLUDE_CODE_DIR

codebase="/mnt/htdocs/farm"
export codebase
alias cddc='cd "$codebase/data/config"; pwd'
alias cdq='cd /mnt/htdocs/queue-worker'
alias cde='cd /mnt/htdocs/ElasticSearch; pwd'
alias cdl='cd /mnt/htdocs/php_library'
alias cdgc='cd /mnt/htdocs/farm-dev-conf; pwd'
alias cdt='cd /mnt/htdocs/tools/ && pwd'
alias cdwc='cd /mnt/htdocs/farm-compile-web && pwd'
alias cdn='cd /mnt/htdocs/notification && pwd'
alias cdcfg='cd /mnt/htdocs/farm-server-conf; pwd'
alias cdlog='cd /mnt/htdocs/logs'

alias hgs='hg status'
alias hgm='hg status | grep "^[a-zA-Z]"'

alias ez='vim ~/.bash_profile'
alias zz='source ~/.bash_profile'
export vpc
vpc="ssh -o SendEnv=CLIENT_NAME yu.jiang@$VPC"
alias ev='vi ~/.vimrc'

function flushdns()
{
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
}

function netgrep()
{
    netstat -anl -p tcp | grep "$1"
}
alias tcp='netgrep'

function listen()
{
    netgrep LISTEN | awk '{printf("%-10s\t%-20s\t%s\n",$1,$4,$6)}' | sort -n -k 2
}
alias listening='lsof -n -i tcp | grep LISTEN'

function connected()
{
    netgrep ESTABLISHED | sort -n -k 4
}

function cman()
{
    man "${1}" | col -b | less
}

function pman()
{
    man -t "${1}" | open -f -a /Applications/Preview.app
}

function hdate()
{
    if [ $# -eq 1 ]; then
        date -r "$1" +"%Y-%m-%d %T"
    else
        date +"%Y-%m-%d %T"
    fi
}
export -f hdate

function now()
{
    timestamp | awk '{print "hdate " $1}' | sh
}
export -f now

function dpub()
{
    dir=$1
    file=$2
    find "$dir" -name "$file" | awk '{print "pub 3 " $1}' | sh
}

function strlen()
{
    string=$1
    echo ${#string}
}

function gufiles()
{
    COMMIT_START=$1
    COMMIT_END=$2
    git show --pretty="format:" --name-only "$COMMIT_START".."$COMMIT_END" | sort | uniq | grep "^[0-9a-zA-Z/_\.]"
}

function find_in_commit()
{
    git log -n 1 -- "$1"
}

function title ()
{
    TITLE=$*
    export PROMPT_COMMAND='echo -ne "\033]0;$TITLE\007"'
}
export -f title
title MAC

function average()
{
    file=$1
    column=$2
    cmd='BEGIN{sum=0;count=0} {count++;sum=sum+$'
    cmd+=$column
    cmd+='; print $'
    cmd+=$column
    cmd+='} END{print "sum=" sum ", average = " sum/count}'
    shell="awk '"
    shell+=$cmd
    shell+="' "
    shell+=$file
    echo "$shell"
    $shell
}

function alldb()
{
    grep -e "'database'" database.php | grep -v -e guest | tr -d "'," | awk '{print $3}' > allDB
}

alias find_debug='grep -R "\bstatic \$debug\b" *'

function crs_server()
{
    platform=''
    if [ $# -eq 1 ]; then
        platform=$1
    else
        green "Usage: ${FUNCNAME[0]} <tw/th/us/br/it/tr/ae/hyves/nk/plingaplay/spil/de/fr/pl/nl/vz/y8>"
        return
    fi

    server=''
    case ${platform} in
        #it|tr|ae|hyves|nk|plingaplay|spil ) server="54.228.208.11";;
        it|tr|ae|hyves|nk|plingaplay|spil|y8 ) server="52.18.3.227";;
        de|fr|pl|nl|vz ) server="52.18.3.227";;
        tw|th ) server="52.74.58.152";;
        us ) server="52.24.20.119";;
        br ) server="10.14.0.187";;
        vpc ) server=${VPC};;
    esac
    echo $server
}
export -f crs_server

function crs()
{
    if [ $# -ne 1 ]; then
        green "Usage: ${FUNCNAME[0]} <tw/th/us/br/it/tr/ae/hyves/nk/plingaplay/spil/de/fr/pl/nl/vz/y8>"
        return
    fi

    local platform=$1
    server=$(crs_server "$platform")
    sshCmd="ssh -i /Users/jiangyu/.ssh/yu.jiang.pem -o SendEnv=CLIENT_NAME yu.jiang@${server}"
    green "$sshCmd"
    $sshCmd
}

function content()
{
    grep -v -e "^;" "$1" | awk 'NF'
}

function md2rst()
{
    if [ $# -eq 0 ]; then
        echo "Usage: ${FUNCNAME[0]} <file.md>"
    else
        FILE=$1
        # replace the + to # chars
        sed -i -r 's/^([+]{4})\s/#### /' "$FILE"
        sed -i -r 's/^([+]{3})\s/### /' "$FILE"
        sed -i -r 's/^([+]{2})\s/## /' "$FILE"
        sed -i -r 's/^([+]{1})\s/# /' "$FILE"
        sed -i -r 's/(\[php\])/<?php/' "$FILE"

        # convert markdown to reStructured Text
        pandoc -f markdown -t rst "$FILE" > "${FILE%.txt}.rst"
    fi
}
export -f md2rst

function git_tag_delete()
{
    tag=$1
    git tag -d "$tag"
    cmd="git push origin :refs/tags/${tag}"
    echo "$cmd"
    $cmd
}
export -f git_tag_delete
alias gt='git tag'

function get_static_uploader()
{
    for file in uploadFbFiles uploadSgFiles
    do
        scp root@10.0.64.56:/mnt/htdocs/dev2/compile/${file}.sh .
    done
}

function pull_config()
{
    if [[ $# -eq 1 ]]; then
        dev=$1
        for file in initscenemap2 struct story_conditions
        do
            cmd="scp root@10.0.64.56:/mnt/htdocs/dev${dev}/farm/data/config/${file}.php /mnt/htdocs/farm/data/config/"
            green "$cmd"
            "$cmd"
        done
    else
        echo "Usage: ${FUNCNAME[0]} <dev num>"
    fi
}

function push_config()
{
    if [[ $# -eq 1 ]]; then
        dev=$1
        for file in initscenemap2 struct story_conditions
        do
            cmd="scp /mnt/htdocs/farm/data/config/${file}.php root@10.0.64.56:/mnt/htdocs/dev${dev}/farm/data/config/"
            green "$cmd"
            $cmd
        done
    else
        echo "Usage: ${FUNCNAME[0]} <dev num>"
    fi
}

alias flush_dns='sudo pkill mDNSResponder'

# phpmd related
function code_size()
{
    phpmd "$1" text codesize,controversial | grep -v -e "\bCURRENT_LANG\b"
}
function code_clean()
{
    phpmd "$1" text cleancode | grep -v -e "\bAvoid using static access\b"
}
function code_design()
{
    phpmd "$1" text design,naming,unusedcode
}
function code_all()
{
    phpmd "$1" text design,naming,unusedcode,cleancode,controversial,codesize | grep -v -e "\bCURRENT_LANG\b"
}
export code_all
function sniffer()
{
    phpcs --colors --standard=~/.composer/vendor/leaphub/phpcs-symfony2-standard/leaphub/phpcs/Symfony2/ "$1"
}

function upcode()
{
    local entry
    entry=$(pwd)
    cdg
    blue "$(pwd)"
    for branch in release-vz release-tw release-th release-us develop master
    do
        gcd $branch
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

function compare_twth()
{
    cdg
    gcd release-tw
    git pull
    gcd release-th
    git pull
    green "compare release-tw with release-th"
    gd release-tw.. --name-only
}
alias tw='gcd release-tw'
alias th='gcd release-th'
alias us='gcd release-us'
alias vz='gcd release-vz'

function get_game_entry()
{
    cdcfg
    grep -rn serverUrl ./* | awk '{print $4}' | cut -d '"' -f 2 | cut -d '/' -f 3
}

trim()
{
    local var="$*"
    var="${var#"${var%%[![:space:]]*}"}"   # remove leading whitespace characters
    var="${var%"${var##*[![:space:]]}"}"   # remove trailing whitespace characters
    echo -n "$var"
}
export -f trim

function elastic_search()
{
    function es_start()
    {
        /usr/local/bin/elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
    }
    function es_stop()
    {
        curl -XPOST 'http://localhost:9200/_shutdown'
    }
    function query()
    {
        local input="'"
        input+=$*
        input+="'"
        local cmd="curl -XGET http://localhost:9200/megacorp/employee/_search -d $input"
        echo "$cmd"
        "$cmd"
    }
}

function json_encode()
{
    export JSON_INPUT="$1"
    php -r '{print_r(json_encode(getenv("JSON_INPUT")));}'
}
function json_decode()
{
    export JSON_INPUT="$1"
    php -r '{print_r(json_decode(getenv("JSON_INPUT"), true));}'
}
alias curl='curl -i'
alias drop_farm='curl -XDELETE http://localhost:9200/farm'

function lsp()
{
    if [ $# -eq 0 ]; then
        echo "Usage: lsp <pattern>"
        return
    fi

    pgrep -l -f "$*"
}
export -f lsp
alias gphpunit='/usr/local/bin/phpunit --verbose'
alias pi='phpunit --configuration ./build/travis-ci.xml'
alias coverage='phpunit --coverage-html coverage'
alias ci='coverage --configuration ./build/travis-ci.xml'
alias refresh='composer update --prefer-dist -vvv --profile -o'
function timezone_id()
{
    php -r 'print_r(timezone_abbreviations_list());' | grep timezone_id | awk '{print $3}' | sort | uniq
}

function parse_family()
{
    grep Entity a | grep "#" | awk '{print $1 " " $3}' | awk -F '\\' '{print $1 " " $5}' | awk '{print $1 "\t" $3}'
}
function phpcsf_dir()
{
    find "$dir" ! -name "$(printf "*\n*")" -name '*.php' > tmp
    local count=0
    while IFS= read -r file
    do
        let count++
        green "Playing file #$count => $file"
        phpcsf "$file"
    done < tmp
    rm tmp
    echo "Processed $count files"
}
alias gup='git stash && git pull'
function pdump()
{
    if [ $# -eq 0 ]; then
        echo "Usage: ${FUNCNAME[0]} <filename>"
        return
    fi
    file=$1
    php -r "require '/mnt/htdocs/farm/vendor/autoload.php'; dump(require '$file');"
}
alias db3="mysql -h 10.0.64.56 -u jiangyu -pnotification farm_dev5"
function test_guild()
{
    /Users/jiangyu/.composer/vendor/bin/phpunit -c /mnt/htdocs/farm/tests/phpunit/phpunit.xml --testsuite Guild
    /Users/jiangyu/.composer/vendor/bin/phpunit -c /mnt/htdocs/farm/tests/phpunit/phpunit.xml --testsuite GuildUtils
    /Users/jiangyu/.composer/vendor/bin/phpunit -c /mnt/htdocs/farm/tests/phpunit/phpunit.xml --testsuite Mailbox
    /Users/jiangyu/.composer/vendor/bin/phpunit -c /mnt/htdocs/farm/tests/phpunit/phpunit.xml --testsuite Sharding
}
function autoload()
{
    /usr/local/bin/composer dump-autoload -o
}

function git_since_last_commit
{
    now=$(date +%s)
    last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    hours_since_last_commit=$((minutes_since_last_commit/60))
    minutes_since_last_commit=$((minutes_since_last_commit%60))

    echo "${hours_since_last_commit}h${minutes_since_last_commit}m "
}
function gdfa()
{
    if [ $# -eq 0 ]; then
        echo "Usage: ${FUNCNAME[0]} <branch>"
        return
    fi
    refBranch=$1
    for branch in master develop release-tw release-th release-us
    do
        green "compare $branch to $refBranch"
        git checkout $branch
        #git diff --name-only $refBranch
        gd --stat "$refBranch"
    done
}
function dockerEnv()
{
    bash -c "clear && DOCKER_HOST=tcp://192.168.99.100:2376 DOCKER_CERT_PATH=/Users/jiangyu/.docker/machine/machines/default DOCKER_TLS_VERIFY=1 /bin/bash"
}

test -e "/Users/jiangyu/.iterm2_shell_integration.bash" && . "/Users/jiangyu/.iterm2_shell_integration.bash"

function es_snsid()
{
    version=$1
    snsid=$2
    cmd="curl -s http://52.19.73.190:9200/farm_v3/user:${version}/${snsid} | tail -1"
    green "$cmd"
    data=$($cmd)
    export JSON_INPUT=$data
    #echo $JSON_INPUT
    php -r "{$arr=json_decode(getenv(\"JSON_INPUT\"), true);if(!isset($arr[\"_source\"])) {echo \"not found\";return;}ksort($arr[\"_source\"]);print_r($arr);}"
    unset JSON_INPUT
}
export es_snsid
function es_uid()
{
    version=$1
    uid=$2
    cmd="curl -s http://52.19.73.190:9200/farm_v3/user:${version}/_search?q=uid:${uid} | tail -1"
    data=$($cmd)
    export JSON_INPUT=$data
    snsid=$(php -r '{print_r(json_decode(getenv("JSON_INPUT"), true));}' | grep snsid | awk '{print $3}')
    green "$JSON_INPUT"
    unset JSON_INPUT
    green "$snsid"
    es_snsid "$version" "$snsid"
}
export es_uid
function getAllHost()
{
    echo "generate host.cache"
    ssh vpc "php /usr/sbin/gethost" > /mnt/htdocs/vpc/host.cache
}
export -f getAllHost
function getHost()
{
    gv=$1
    type=$2
    if [ ! -f /mnt/htdocs/vpc/host.cache ]; then
        getAllHost
    fi
    grep farm-"$gv"-"$type" /mnt/htdocs/vpc/host.cache | awk -F ',' '{if (length($2)) print $2;}'
}
export -f getHost
alias fssh="ssh -F /Users/jiangyu/.ssh/vpc_config"
function fscp()
{
    cmd="scp -F /Users/jiangyu/.ssh/vpc_config $*"
    green "$cmd"
    $cmd
}
export -f fscp

function notif()
{
    if [ $# -ne 1 ]; then
        echo "Usage: ${FUNCNAME[0]} <gameVersion>"
        return
    fi
    ipAddress=$(getHost "$1" notif)
    green "$ipAddress"
    fssh "$ipAddress"
}

function countHost()
{
    date=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$date"

    allHost=0
    allProxy=0
    allWeb=0
    allCache=0
    allMysql=0
    allMongo=0
    allNotif=0
    printf "%7s %7s %7s %7s %7s %7s %7s %7s\r\n" "version" "proxy" "web" "cache" "MySQL" "mongo" "notif" "total"
    for gv in us ae fr de br nl pl th tw it spil nk vz hyves y8 plinga
    do
        proxyCount=$(getHost $gv proxy | wc -l)
        webCount=$(getHost $gv web | wc -l)
        cacheCount=$(getHost $gv cache | wc -l)
        mysqlCount=$(getHost $gv mysql | wc -l)
        mongoCount=$(getHost $gv mongo | wc -l)
        notifCount=$(getHost $gv notif | wc -l)
        total=$((proxyCount + webCount + cacheCount + mysqlCount + mongoCount + notifCount))
        allHost=$((allHost + total))
        allProxy=$((allProxy + proxyCount))
        allWeb=$((allWeb + webCount))
        allCache=$((allCache + cacheCount))
        allMysql=$((allMysql + mysqlCount))
        allMongo=$((allMongo + mongoCount))
        allNotif=$((allNotif + notifCount))
        printf "%7s %7d %7d %7d %7d %7d %7d %7d\r\n" "$gv" "$proxyCount" "$webCount" "$cacheCount" "$mysqlCount" "$mongoCount" "$notifCount" "$total"
    done

    printf "%7s %7d %7d %7d %7d %7d %7d %7d\n" "summary" "$allProxy" "$allWeb" "$allCache" "$allMysql" "$allMongo" "$allNotif" "$allHost"
}
export -f countHost
function inspectHosts()
{
    getAllHost
    date=$(date +"%Y%m%dT%H")
    countHost > "/Users/jiangyu/inspectation/${date}"
}
export -f inspectHosts

function db1()
{
    cd "/mnt/htdocs/farm-server-conf" || die "cdcfg fail"
    cd "facebook_$1" || return
    database=$(grep "'db1'" database.php -A 10 | grep database | awk '{print $3}' | tr -d ",'")
    green "$database"
    host=$(grep "'db1'" database.php -A 10 | grep host | awk '{print $3}' | tr -d ",'")
    green "$host"
    #fssh "$host"
}
export -f db1
function deploy_notif()
{
    gv=$1
    file=$2
    local cmd
    cmd="scp -F /Users/jiangyu/.ssh/vpc_config $file $(getHost "$gv" notif):/mnt/htdocs/notif2/$file"
    #cmd="scp -F /Users/jiangyu/.ssh/vpc_config $file $(getHost $gv notif):/mnt/htdocs/notification/$file"
    echo "$cmd"
    $cmd
}
export -f deploy_notif
function ppu()
{
    if [[ -e bootstrap.php ]]; then
        phpunit --bootstrap bootstrap.php "$*"
    else
        phpunit "$*"
    fi
}
function sync_tw_notif()
{
    gs | awk '{print "deploy_notif tw " $2}'
}
function sync_us_notif()
{
    gs | awk '{print "deploy_notif us " $2}'
}
function supply_progress()
{
    if [[ $# -ne 1 ]]; then
        red "Usage: ${FUNCNAME[0]} <gameVersion>"
        return
    fi
    version=$1
    host=''
    if [[ "$version" = "th" ]]; then
        host=$(getHost tw notif)
    fi
    if [[ "$version" = "it" || "$version" = "fr" || "$version" = "pl" || "$version" = "nl" ]]; then
        host=$(getHost de notif)
    fi
    if [[ "$host" = "" ]]; then
        host=$(getHost "$version" notif)
    fi
    green "version=$version, host=$host"
    fssh "$host" "cd /mnt/htdocs/notif2/log/marker_3/$version && ls | awk -F '-' '{print \$1}' | sort -n | uniq -c"
}
eval "$(/usr/libexec/path_helper -s)"

alias le='learnyounode'
alias how='how-to-npm'
alias mate='gcd feature/5th_mating'
alias alog='tail -f /mnt/htdocs/logs/local.alog'
alias liquid='source ~/liquidprompt/liquidprompt'
function precompile()
{
    export dir
    dir="$(pwd)"
    if ! cd "$codebase" ; then
        return
    fi
    if [ ! -d "cli/preCompile" ]; then
        return;
    fi;

    cd cli/preCompile || return
    if [ -f "getCompilers.php" ]; then
        files=$(php getCompilers.php | head -1)
    else
        files=$(ls build*.php)
    fi
    for file in $files
    do
        blue "$file"
        php "$file" --lang en_US
    done
    cd "$dir" || red "$dir not exist"
}
function self_check()
{
    self_check_animal
}
function self_check_animal()
{
    cdg
    if ! cd cli/Animal
    then
        red "no cli/Animal"
        return
    fi
    php couples.php --dump && php couples.php --ids && php couples.php --species moa && php couples.php --id 371001
}
function snsid()
{
    php /mnt/htdocs/farm/cli/user.php --snsid "$1"
}
function uid()
{
    php /mnt/htdocs/farm/cli/user.php --uid "$1"
}
function drop_5th_scene()
{
    if [ $# -ne 1 ]; then
        red "Usage: ${FUNCNAME[0]} <snsid>"
        return;
    fi
    local snsid=$1
    php /mnt/htdocs/farm/cli/Scene5th/dropScene.php --drop --snsid "$snsid"
}
function add_5th_scene()
{
    if [ $# -ne 1 ]; then
        red "Usage: ${FUNCNAME[0]} <snsid>"
        return;
    fi
    local snsid=$1
    php /mnt/htdocs/farm/cli/Scene5th/addScene.php --snsid "$snsid"
}
function story()
{
    php /mnt/htdocs/farm/cli/story.php "$@"
}
alias two='gcd feature/two-way-sync-neighbor'
alias dps='docker ps'
alias di='docker images'
function cgrep()
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
function ff_env()
{
    if [ $# -ne 1 ]; then
        red "Usage: ${FUNCNAME[0]} <game version>"
        return;
    fi
    local version=$1
    local dir=/mnt/htdocs/farm-server-conf/facebook_"$version"
    if [ ! -d "$dir" ]; then
        dir=/mnt/htdocs/farm-server-conf/$version
        if [ ! -d "$dir" ]; then
            red "version $version not found"
            return
        fi
    fi
    for file in facebook.php game.php struct.php
    do
        cp -f /mnt/htdocs/farm/data/config/$file /mnt/htdocs/farm/data/config/$file.orig
        local path="$dir/$file"
        if [ ! -f "$path" ]; then
            continue
        fi
        local cmd="cp $path /mnt/htdocs/farm/data/config/"
        $cmd

    done
    php /mnt/htdocs/farm/cli/env.php

    for file in facebook.php game.php struct.php
    do
        local cmd="cp -f /mnt/htdocs/farm/data/config/$file.orig /mnt/htdocs/farm/data/config/$file"
        $cmd
    done
}
function warmup_us()
{
    host=$1
    fssh "$host" "curl --silent --no-keepalive http://localhost/warmup.php?langCode=am"
    fssh "$host" "curl --silent --no-keepalive http://localhost/warmup.php?langCode=de"
    fssh "$host" "curl --silent --no-keepalive http://localhost/warmup.php?langCode=fr"
    fssh "$host" "curl --silent --no-keepalive http://localhost/warmup.php?langCode=nl"
    fssh "$host" "curl --silent --no-keepalive http://localhost/warmup.php?langCode=pt"
    fssh "$host" "curl --silent --no-keepalive http://localhost/warmup.php?langCode=es"
    fssh "$host" "curl --silent --no-keepalive http://localhost/warmup.php?langCode=ar"
    fssh "$host" "curl --silent --no-keepalive http://localhost/warmup.php?langCode=tu"
}
function fup()
{
    fssh "$1" "uptime"
}
function countweb()
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
        if ! $cmd
            then
            red "$cmd failed"
            return
        fi
    fi
    grep -v -e 127.0.0.1 "$localFile" | grep server | awk 'BEGIN{num=0}{num=num+1; print $2;}END{print "total="num}'
}
export -f countweb
function max_id_achievement()
{
    grep "'id'" /mnt/htdocs/farm/data/config/achievement.php  | awk -F "=>" '{print $2}' | sort -n | tail -10
}
function find_large_files()
{
    if [ $# -ne 2 ]; then
        echo "Usage: ${FUNCNAME[0]} <dir> <size>"
        return
    fi
    local dir=$1
    local size=$2
    find "$dir" -type f -size +"$size" -exec /bin/ls -lh {} \; | awk '{ print $5 " " $9 }'
}
alias anode='node --harmony-async-await'
function webarray()
{
    if [ $# -ne 1 ]; then
        red "Usage: ${FUNCNAME[0]} <game version>"
        return
    fi
    local server
    case $1 in
        it ) server="54.72.211.81";;
        tw ) server="54.255.199.63";;
        th ) server="54.255.199.222";;
        us ) server="54.164.147.29";;
        br ) server="54.94.174.54";;
        pl ) server="54.77.141.243";;
        nl ) server="54.72.3.11";;
        de ) server="54.77.153.103";;
        fr ) server="54.77.74.125";;
    esac
    local url="http://$server/tools/cache.php?cacheKey=online_web_array&json=1"
    green "$url"
    curl --silent "$url"
}
function pwebarray()
{
    if [ $# -ne 1 ]; then
        red "Usage: ${FUNCNAME[0]} <game version>"
        return
    fi
    json_decode "$(webarray "$1" | tail -1)"
}
function cds()
{
    if [ $# -ne 1 ]; then
        red "Usage $FUNCNAME <gameVersion>"
        return 1
    fi
    cdd $1
    cd static || return
}
function cdd()
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
