#!/bin/bash

set -xe

apt update && apt install -yq wget unzip p7zip openjdk-14-jre

echo "Working out of /opt for our qortal core install."
pushd /opt

wget https://github.com/Qortal/qortal/releases/download/v1.4.2/qortal-1.4.2.zip
unzip qortal-1.4.2.zip

echo "Our qortal core is installed in '/opt/qortal'"
pushd /opt/qortal

# Make our scripts executable
chmod +x start.sh
chmod +x stop.sh

echo "Edit our settings to ensure we have at least 8 blockchain peers"
cat << EOF > settings.json
{
    "minBlockchainPeers": 8
}
EOF

echo "Grabbing the bootstrap file."
wget https://qortaldb-snapshots.sfo3.cdn.digitaloceanspaces.com/qortal-db-2021-02-19.7z
p7zip -d qortal-db-2021-02-19.7z

echo "Create our qortal user and group"
groupadd qortal
useradd -g qortal -d /opt/qortal -s /usr/bin/bash qortal

echo "Set /opt/qortal to be owned by our qortal user"
chown -R qortal:qortal /opt/qortal

echo "Start up qortal!"
su - qortal -c "/opt/qortal/start.sh"
