#!/bin/bash
#
# insurance-integration         start/stop/status script
#
# chkconfig:  2345 64 36
# description: Console service for insurance-integration
# processname: insurance-integration
# config: /etc/insurance-integration

IMIS_CONNECT_USER='bahmni'

imisConnectPid() {
    echo `ps -fe | grep 'insurance-integration*.jar' | grep -v grep | tr -s " "|cut -d" " -f2`
    #echo ´ps -fe | grep 'insurance-integration*.jar' | grep -v grep | tr -s " "|cut -d" " -f2´

}

start(){
    pid=$(imisConnectPid)
    if [ -n "$pid" ]
    then
        echo -e "\e[00;31mService insurance-integration is already running (pid: $pid)\e[00m"
    else
        /bin/su -s /bin/bash bahmni /opt/insurance-integration/bin/start.sh
        echo -e "\e[00;32mStarting insurance-integration\e[00m"
    fi
    return 0
}

debug() {
    pid=$(imisConnectPid)
    if [ -n "$pid" ]
    then
        echo -e "\e[00;31mService insurance-integration is already running (pid: $pid)\e[00m"
    else
        /bin/su -s /bin/bash ${IMIS_CONNECT_USER} /opt/insurance-integration/bin/debug.sh
        echo -e "\e[00;32mStarting insurance-integration in debug mode\e[00m"
    fi
    return 0
}
status() {
    pid=$(imisConnectPid)
    if [ -n "$pid" ];
    then
        echo -e "\e[00;32minsurance-integration is running with pid: $pid\e[00m"
        exit 0
    else
        echo -e "\e[00;31minsurance-integration is not running\e[00m"
        exit 3
    fi
}

stop() {
    pid=$(imisConnectPid)
    if [ -n "$pid" ];
    then
        echo -e "\e[00;31mTerminating insurance-integration\e[00m"
        kill -9 ${pid}
    else
        echo -e "\e[00;31minsurance-integration is not running\e[00m"
    fi
    return
}