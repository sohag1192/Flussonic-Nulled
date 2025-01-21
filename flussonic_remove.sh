#!/bin/bash

# This script will work on Ubuntu 18, Ubuntu 20 
# of the same families, although no support is offered for them. It isn't
# It has been designed to be as unobtrusive and
# universal as possible.

# This is a free shell script under GNU GPL version 3.0 or above
# Copyright (C) 2017 LinuxHelps project.

# ⚠️  Any sharing of the script will cause it to stop working ⚠️ 
clear

date=`date '+%m-%d-%y-%H_%M_%S'`
current_dir=`pwd`

Copy() {
    
    if [ -f "/etc/flussonic/flussonic.conf" ]; then
    echo "Previous Flusssonic Config Found, Taking Backup..."
    cp /etc/flussonic/flussonic.conf $current_dir/
    sudo mv /etc/flussonic/flussonic.conf $current_dir/flussonic.conf_backup_$date
    fi  
}

Remove() {

    if ! dpkg -s flussonic >/dev/null 2>&1; then
        echo "Remove old Flussonic..."
    else
        apt-get remove flussonic\* --purge -y > /dev/null 2>&1
    fi
    if [ -d "/etc/flussonic" ]; then
        sudo rm -rf /etc/flussonic
    fi
    if [ -d "/opt/flussonic" ]; then
        sudo rm -rf /opt/flussonic
    fi  
    sudo apt-get -y autoremove > /dev/null 2>&1
    systemctl is-active --quiet flussonic && systemctl stop flussonic || echo "No running flussonic found"

    if [ -f "/etc/systemd/system/multi-user.target.wants/flussonic.service" ]; then
        echo "found service"
        sudo systemctl disable flussonic
    fi

    sudo systemctl daemon-reload
    sudo systemctl reset-failed

    sudo rm -f /etc/apt/sources.list.d/flussonic.list
    sudo rm -f /etc/apt/sources.list.d/erlyvideo.list

}

PrintConfigPath() {

    if [ -f "$current_dir/flussonic.conf_backup_$date" ]; then
            echo -e "\nYour existing backup file is: $current_dir/flussonic.conf_backup_$date \n"
    fi


}

Copy
Remove
PrintConfigPath
