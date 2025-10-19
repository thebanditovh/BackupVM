# :bird: BackupVM

  Site : https://the-bandit.ovh
  
  Discord : https://discord.the-bandit.ovh
  
  Support : https://support.the-bandit.ovh
  
  License : https://licence.the-bandit.ovh
  

## Utilisez cron pour planifier des sauvegardes

```bash
$ crontab -e
```
Par exemple, pour que le script s'exécute à 2 h 00 du matin tous les jours, nous ouvririons cron avec la commande suivante :

_\* Et ajoutez la ligne suivante à cron :_
```bash
0 2 * * * /bin/bash <(/usr/bin/curl -s https://raw.githubusercontent.com/thebanditovh/BackupVM/refs/heads/main/bvm.bash) "hostSSH" "portSSH" "userSSH" "passSSH" "dir"
```

Commande pour executer une backup
```bash
/bin/bash <(/usr/bin/curl -s https://raw.githubusercontent.com/thebanditovh/BackupVM/refs/heads/main/bvm.bash) "hostSSH" "portSSH" "userSSH" "passSSH" "dir"
```
