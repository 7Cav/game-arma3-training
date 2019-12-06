#!/bin/bash

# house keeping
apt -y update
apt -y --no-install-recommends install curl
apt -y --no-install-recommends install lib32gcc1 ca-certificates

# download steamCMD
cd /tmp
curl -sSLO http://media.steampowered.com/installer/steamcmd_linux.tar.gz
tar -xzvf /tmp/steamcmd_linux.tar.gz -C /mnt/server/steamcmd

# setup server profile
mkdir -p /mnt/server/steamcmd /mnt/server/logs
mkdir -p "/mnt/server/.local/share/Arma 3" "/mnt/server/.local/share/Arma 3 - Other Profiles/server"
cd "/mnt/server/.local/share/Arma 3 - Other Profiles/server"
curl -sSLO ${PROFILE_CONFIG_URL}
touch /mnt/server/latest.log
chown -R root:root /mnt

# download server files
cd /mnt/server/steamcmd
export HOME=/mnt/server

./steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +force_install_dir /mnt/server +app_update ${APP_ID} validate +quit

cd /mnt/server/

# download arma3.cfg
curl -sSLO ${BASE_CONFIG_URL}

# download server.cfg
curl -sSLO ${SERVER_CONFIG_FILE_URL}
