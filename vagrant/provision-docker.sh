#!/bin/sh

echo "Provision Docker"
# (cf. https://docs.docker.com/engine/installation/linux/ubuntulinux/)

# update apt sources
apt-get update
echo "Setup docker APT repositories"
apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-cache policy docker-engine

# prerequisites
# apt-get install linux-image-extra-$(uname -r)
# apt-get install apparmor

# install docker
# as of now version 18.06 is greater than the most receently version 17.03
# however, that version is not available for Ubuntu 18.04 (at least that is what "apt-cache madison docker-ce" reports)
apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu

# add an additional service configuration file that contains required environment variables
# and override the ExecStart property
mkdir -p /etc/systemd/system/docker.service.d
cp docker.service.conf /etc/systemd/system/docker.service.d/

systemctl daemon-reload
service docker restart

usermod -aG docker vagrant

# update the locale LANG
update-locale LANG=en_US.UTF-8

