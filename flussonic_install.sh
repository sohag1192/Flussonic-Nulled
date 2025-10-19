#!/bin/bash

cur_date=`date`
var1=`cat /etc/profile | grep -w HISTSIZE`
ret=`echo $?`
me=$(basename "$0")
current_dir=`pwd`

if [ "$ret" == 1 ]; then
        sudo echo "# $cur_date" >> /etc/profile
        echo -e "\n"
        sudo echo "HISTSIZE=2000" >> /etc/profile
        sudo echo "HISTTIMEFORMAT='%F %T '" >> /etc/profile
        echo -e " ... updated profile in etc on $cur_date  ... \n"
else
        echo -e " ... profile is already updated .... \n"
fi
#---------------------------------------------------
server_ip=`curl -s ipinfo.io/ip`
echo -e "\n************ Server IP: $server_ip **********\n"
echo -e "\nUpdating....\n"
sudo apt update
sudo apt install net-tools unzip -y

echo -e "\n updates are done...."

if [ ! -d /tmp/fsonicauto ]; then
        echo -e "\ncreating temp dir and downloading software files...\n"
        mkdir -p /tmp/fsonicauto;
       
        # sudo wget -P /tmp/fsonicauto --user=software --password='glastp' ftp://202.59.80.109/23.02_new_file.zip
        sudo wget -P /tmp/fsonicauto https://raw.githubusercontent.com/XtechGlobal-Server/flussonic/main/23.02.zip
        
        # cd /tmp/fsonicauto; sudo unzip 23.02_new_file.zip
        cd /tmp/fsonicauto; sudo unzip 23.02.zip

        #cd /tmp/fsonicauto/23.02_new_file
        cd /tmp/fsonicauto/23.02
        echo -e "\n checking software installtion status ..\n"
        sudo dpkg -l | grep ^ii | grep flussonic > /dev/null
        ret=`echo $?`
        if [ "$ret" == 1 ]; then
                echo -e '\n... software unpacked. Installing software..';
                sudo dpkg -i flussonic*

                echo -e "\n ... Installation done ...\n"
                echo -e "\n activating flussonic service \n"
                if [ -f "/etc/systemd/system/multi-user.target.wants/flussonic.service" ]; then
                        echo "found service"
                        sudo systemctl enable flussonic
                        sudo systemctl start flussonic
                fi
                #lic=`sudo cat /etc/flussonic/license.txt`
                lic="o4|000000000000000000000|NulledBySlaSerXDEV"
                password=$(tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 10)
                echo -e "\n ... Please open ** http://$server_ip ** in browser and add following information.
                License Key: "$lic"
                Login: admin_noc
                Password: $password \n
                Click: Activate Media Server

                Once you are logged in to the server, navigate to config, scroll down to the end of the page, press Upload Config

                After uploading configuration using web URL, You need to login to server using the credentials mentioned in your backup configuration file.


                \n"

                sudo rm -f /etc/apt/sources.list.d/flussonic.list
                sudo rm -f /etc/apt/sources.list.d/erlyvideo.list

                echo -e "\n ... list files are removed to avoid updates ..."
        else
                echo -e "\n ... Flussonic is already installed ...";

        echo ""
        exit 0
        fi
else
        echo -e "\nI did not create temp folder\n"
        if [ -f /tmp/fsonicauto/23.02.zip ]; then
                echo -e "\nsoftware file exist. Please run following command.
                sudo rm -r /tmp/fsonicauto
                and execute sudo ./$me
                \n"
        else
                echo -e "temp folder exist but no software .zip\n"
        fi
fi
