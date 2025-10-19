#!/bin/bash
# =========================================================================
# Configuration
# =========================================================================

INSTALL_DIR="/tmp"

# Répertoire de destination de la backup.
DEST_DIR="$5"

# Adresse ip ssh.
DEST_HOST="$1"

# Port ssh
DEST_PORT="$2"

# Utilisateur ssh.
DEST_USER="$3"

# Mots de passe ssh.
DEST_PASS="$4"

cat <<EOF >${INSTALL_DIR}/bvm.bash
#!/bin/bash
# =========================================================================
apt -y update
apt -y install rsync
apt -y install sshpass

sshpass -p "${DEST_PASS}" ssh -o StrictHostKeyChecking=no -p ${DEST_PORT} "mkdir -p ${DEST_DIR}/$(hostname -f)"

if [ -d "/var/lib/pterodactyl" ]; then
  rsync -avP -e 'sshpass -p "${DEST_PASS}" ssh -o StrictHostKeyChecking=no -p ${DEST_PORT}' /var/lib/pterodactyl/ ${DEST_USER}@${DEST_HOST}:${DEST_DIR}/$(hostname -f)/pterodactyl
fi

if [ -d "/var/www" ]; then
  rsync -avP -e 'sshpass -p "${DEST_PASS}" ssh -o StrictHostKeyChecking=no -p ${DEST_PORT}' /var/www/ ${DEST_USER}@${DEST_HOST}:${DEST_DIR}/$(hostname -f)/www
fi

if [ -d "/var/log" ]; then
  rsync -avP -e 'sshpass -p "${DEST_PASS}" ssh -o StrictHostKeyChecking=no -p ${DEST_PORT}' /var/log/ ${DEST_USER}@${DEST_HOST}:${DEST_DIR}/$(hostname -f)/log
fi

if [ -d "/etc/apache2" ]; then
  rsync -avP -e 'sshpass -p "${DEST_PASS}" ssh -o StrictHostKeyChecking=no -p ${DEST_PORT}' /etc/apache2/ ${DEST_USER}@${DEST_HOST}:${DEST_DIR}/$(hostname -f)/apache2
fi

if [ -d "/etc/nginx" ]; then
  rsync -avP -e 'sshpass -p "${DEST_PASS}" ssh -o StrictHostKeyChecking=no -p ${DEST_PORT}' /etc/apache2/ ${DEST_USER}@${DEST_HOST}:${DEST_DIR}/$(hostname -f)/nginx
fi

if [ -d "/etc/php" ]; then
  rsync -avP -e 'sshpass -p "${DEST_PASS}" ssh -o StrictHostKeyChecking=no -p ${DEST_PORT}' /etc/apache2/ ${DEST_USER}@${DEST_HOST}:${DEST_DIR}/$(hostname -f)/php
fi
# =========================================================================
EOF
chmod 777 ${INSTALL_DIR}/bvm.bash
cd ${INSTALL_DIR} && ./bvm.bash
sleep 1
rm ${INSTALL_DIR}/bvm.bash
