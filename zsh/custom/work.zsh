if [[ `hostname` == W4DEUMSY9002036 || `hostname` == debian ]]; then
    export http_proxy="http://proxy.mms-dresden.de:8080"
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export no_proxy=127.0.0.1,localhost

    export VBOX_USER_HOME='C:/Develop/VMs'
    export VAGRANT_HOME='C:/Develop/VMs/.vagrant.d'
    export CHECKOUT_ROOT='C:/Develop/code'

    alias poedit="/cygdrive/c/Program\ Files\ \(x86\)/Poedit/Poedit.exe"
    alias mvn="/cygdrive/c/Users/lakr/Tools/apache-maven-3.3.3/bin/mvn"

    alias jive='~/.venv/sandbox/bin/python ~/code/sandbox/jive.py'

    # load alias file with customer names not shared here
    if [[ -f ~/.secret_aliases.zsh ]]; then
      source ~/.secret_aliases.zsh
    fi;

    rup() {
        for DIR in $(find . -mindepth 1 -maxdepth 1 -type d); do
            cd $DIR
            echo "Updating $DIR ..."
            if [[ -d '.git' ]]; then
                git pull
            elif [[ -d '.svn' ]]; then
                svn cleanup
                svn up
            fi
            cd ..
        done
    }
fi
if [[ `hostname` == W4DEUMSY9002036 || `hostname` == debian ]]; then
    export PATH=~/tools/apache-maven-3.3.3/bin:$PATH
    alias mvn=mvn-color
    alias jive='~/venv/jive/bin/python ~/code/sandbox/jive.py'
    alias pc='~/code/proxychains-ng/proxychains4 -q -f ~/code/proxychains-ng/src/proxychains.conf'

    mvn_version_release() {
        ~/tools/apache-maven-3.3.3/bin/mvn versions:set -DnewVersion=$1
        git add pom.xml */pom.xml
        git commit -m "release version $1"
        git tag -a $1 -m "tag release version $1"
        git push
        git push --tags
        ~/tools/apache-maven-3.3.3/bin/mvn versions:commit
    }
    mvn_version_snapshot() {
        ~/tools/apache-maven-3.3.3/bin/mvn versions:set -DnewVersion=$1-SNAPSHOT
        git add pom.xml */pom.xml
        git commit -m "set snapshot version $1-SNAPSHOT"
        git push
        ~/tools/apache-maven-3.3.3/bin/mvn versions:commit
    }
fi
if [[ "`id -nu`" == "vagrant" ]]; then
    MSM=`echo /**/usr/local/*/mediasuite/bin/manage`
    WSM=`echo /**/usr/local/*/webcastsuite/bin/manage`

    alias msm=$MSM
    alias wsm=$WSM
    alias msm="/usr/local/*/mediasuite/bin/manage"
    alias wsm="/usr/local/*/webcastsuite/bin/manage"
    alias wsim="/usr/local/*/wsi/bin/manage"

    alias msr="while true; do find /py -name '*.pyc' -delete; msm runserver 8000; sleep 1; done"
    alias msc="msm runcelery worker -BQ celery,ffmpeg -l info --autoreload --autoscale=6,3"
    alias wsr="while true; do find /py -name '*.pyc' -delete; wsm runserver 8100; sleep 1; done"
    alias wsc="wsm runcelery worker -BQ celery,highprio -l info --autoreload --autoscale=8,4"
    alias wsir="while true; do find /py -name '*.pyc' -delete; wsim runserver 8200; sleep 1; done"

    alias msp="/usr/local/*/mediasuite/bin/pip"
    alias wsp="/usr/local/*/webcastsuite/bin/pip"
    alias wsip="/usr/local/*/wsi/bin/pip"
    alias sv="/usr/local/*/supervisor/bin/supervisorctl"

    if [[ -x /opt/python/bin/python ]]; then
        export PATH=/opt/python/bin:$PATH
    fi
    if [[ -x ~/virtualenv/bin/pyrun ]]; then
        export PATH=~/virtualenv/bin:$PATH
    fi
    export STAGE=vagrant
    cd /vagrant
fi
