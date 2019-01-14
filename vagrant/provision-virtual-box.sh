#!/bin/sh

echo "Provision VirtualBox"
# (cf. https://www.virtualbox.org/wiki/Linux_Downloads)

# update apt sources
apt-get update
echo "Setup VirtualBox APT repositories"
apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | apt-key add -
apt-key fingerprint B9F8 D658 297A F3EF C18D  5CDF A2F6 83C5 2980 AECF
add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
apt-get update

apt-get install virtualbox-6.0
