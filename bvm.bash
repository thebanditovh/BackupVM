#!/bin/bash
INSTALL_DIR="/etc"

apt -y update
apt -y install rsync
apt -y install sshpass

cat <<EOF >${INSTALL_DIR}/bvm.bash
#!/bin/bash
# =========================================================================
# Configuration
# =========================================================================

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

# =========================================================================

sshpass -p "\$DEST_PASS" ssh \$DEST_USER@\$DEST_HOST -o StrictHostKeyChecking=no -p \$DEST_PORT "mkdir -p \$DEST_DIR/\$(hostname -f)"

if [ -d "/var/lib/pterodactyl" ]; then
  rsync -avP --delete -e 'sshpass -p "'\$DEST_PASS'" ssh -o StrictHostKeyChecking=no -p --exclude='/var/lib/pterodactyl/backups' '\$DEST_PORT /var/lib/pterodactyl/ \$DEST_USER@\$DEST_HOST:\$DEST_DIR/\$(hostname -f)/pterodactyl
fi

if [ -d "/var/www" ]; then
  rsync -avP --delete -e 'sshpass -p "'\$DEST_PASS'" ssh -o StrictHostKeyChecking=no -p '\$DEST_PORT /var/www/ \$DEST_USER@\$DEST_HOST:\$DEST_DIR/\$(hostname -f)/www
fi

if [ -d "/var/log" ]; then
  rsync -avP --delete -e 'sshpass -p "'\$DEST_PASS'" ssh -o StrictHostKeyChecking=no -p '\$DEST_PORT /var/log/ \$DEST_USER@\$DEST_HOST:\$DEST_DIR/\$(hostname -f)/log
fi

if [ -d "/etc/apache2" ]; then
  rsync -avP --delete -e 'sshpass -p "'\$DEST_PASS'" ssh -o StrictHostKeyChecking=no -p '\$DEST_PORT /etc/apache2/ \$DEST_USER@\$DEST_HOST:\$DEST_DIR/\$(hostname -f)/apache2
fi

if [ -d "/etc/nginx" ]; then
  rsync -avP --delete -e 'sshpass -p "'\$DEST_PASS'" ssh -o StrictHostKeyChecking=no -p '\$DEST_PORT /etc/apache2/ \$DEST_USER@\$DEST_HOST:\$DEST_DIR/\$(hostname -f)/nginx
fi

if [ -d "/etc/php" ]; then
  rsync -avP --delete -e 'sshpass -p "'\$DEST_PASS'" ssh -o StrictHostKeyChecking=no -p '\$DEST_PORT /etc/apache2/ \$DEST_USER@\$DEST_HOST:\$DEST_DIR/\$(hostname -f)/php
fi

if [ -d "/startup" ]; then
  
  if [ -f "/startup/backup.sh" ]; then
     /bin/bash /startup/backup.sh
  fi
  
  rsync -avP --delete -e 'sshpass -p "'\$DEST_PASS'" ssh -o StrictHostKeyChecking=no -p '\$DEST_PORT /backup/ \$DEST_USER@\$DEST_HOST:\$DEST_DIR/\$(hostname -f)/startup
  #rm -R /backup
  
fi
# =========================================================================

EOF

chmod 777 ${INSTALL_DIR}/bvm.bash

echo -e "# ========================================================================="
echo -e "# Configuration Cron"
echo -e "# ========================================================================="
echo -e ""
echo -e "Par exemple, pour que le script s'exécute à 2 h 00 du matin tous les jours, nous ouvririons cron avec la commande suivante :"
echo -e "Et ajoutez la ligne suivante à cron :"
echo -e ""
echo -e "0 2 * * * /bin/bash $INSTALL_DIR/bvm.bash"
echo -e ""


