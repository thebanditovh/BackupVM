# :bird: BackupVM

  Site : https://the-bandit.ovh
  
  Discord : https://discord.the-bandit.ovh
  
  Support : https://support.the-bandit.ovh
  
  License : https://licence.the-bandit.ovh
  

## Utilisez cron pour planifier des sauvegardes

Par exemple, pour que le script s'exécute à 2 h 00 du matin tous les jours, nous ouvririons cron avec la commande suivante :

```bash
$ crontab -e
```

Et ajoutez la ligne suivante à cron :
```bash
0 2 * * * /bin/bash /etc/bvm.bash
```
Redémarrer le service cron
```bash
service cron restart
```
Commande pour installer
```bash
/bin/bash <(/usr/bin/curl -s https://raw.githubusercontent.com/thebanditovh/BackupVM/refs/heads/main/bvm.bash) "hostSSH" "portSSH" "userSSH" "passSSH" "dir"
```
