#!/bin/bash
echo "What is the hostname"
read HOSTNAME
echo " " > /etc/hostname
echo "$HOSTNAME" >> /etc/hostname

echo "alias 'll=ls -al'" >> /etc/profile

########################################## Installing Applications ################################
sudo apt-get update -y
sudo apt-get install net-tools vim su git curl wget apache2 ca-certificates gnupg -y 
########################################### Installing Jellyfin ######################################
curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash

########################################### Installing Docker ########################################
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update