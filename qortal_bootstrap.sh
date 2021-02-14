#!/bin/bash

set -xe

apt update && apt install -yq wget unzip openjdk-14-jre

echo "Working out of /opt for our qortal core install."
pushd /opt

wget https://github.com/Qortal/qortal/releases/download/v1.4.1/qortal-1.4.1.zip
unzip qortal-1.4.1.zip

echo "Our qortal core is installed in '/opt/qortal'"
pushd /opt/qortal

# Make our scripts executable
chmod +x start.sh
chmod +x stop.sh

echo "Grabbing the bootstrap file."
wget https://cloud.crowetic.com/s/6rDwKQji3tARNcx/download && mv download db-crowetic-2.1.2021.zip
unzip db-crowetic-2.1.2021.zip

echo "Create our qortal user and group"
groupadd qortal
useradd -g qortal qortal

echo "Set /opt/qortal to be owned by our qortal user"
chown -R qortal:qortal /opt/qortal

echo "Start up qortal!"
su - qortal -c "/opt/qortal/start.sh"
