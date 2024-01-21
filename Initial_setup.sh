#!/bin/bash
echo "What is the hostname"
read HOSTNAME
echo " " > /etc/hostname
echo "$HOSTNAME" >> /etc/hostname

echo "alias 'll=ls -al'" >> /etc/profile

########################################## Installing Applications ################################
sudo apt-get update -y
sudo apt-get install net-tools vim su git curl wget apache2 ca-certificates gnupg nfs-common cifs-utils -y 

########################################### Fstab ####################################################
###### setup smb share to Synology ##########
touch /etc/smbcredentials
echo "username=download\npassword=" >> /etc/smbcredentials
chmod 600 /etc/smbcredentials
sudo mkdir /backup
sudo echo "//192.168.1.5/Open_Share /backup cifs rw,uid=1001,gid=1001,credentials=/etc/smbcredentials" >> /etc/fstab
### add \040 for the space 
#//192.168.1.5/Plex/Kids\040Islamic\040Cartoon /Plex cifs credentials=/etc/smbcredentials,rw,uid=1002,gid=1002
adduser download
########################################### Installing Jellyfin ######################################
curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash

########################################### Installing Docker ########################################
# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

######################################## Configuration twiking ##################
#close the lid and not go to sleep
echo -e "HandleLidSwitch=ignore" >> /etc/systemd/logind.conf
systemctl restart systemd-logind