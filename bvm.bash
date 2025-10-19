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
rsync -avP -e 'sshpass -p "${DEST_PASS}" ssh -o StrictHostKeyChecking=no -p ${DEST_PORT}' /var/lib/pterodactyl/ ${DEST_USER}@${DEST_HOST}:${DEST_DIR}/$(hostname -f)
# =========================================================================
EOF
chmod 777 ${INSTALL_DIR}/bvm.bash
cd ${INSTALL_DIR} && ./bvm.bash
sleep 1
rm ${INSTALL_DIR}/bvm.bash
