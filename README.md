# :bird: BackupVM

## Utilisez cron pour planifier des sauvegardes

```bash
$ crontab -e
```
Par exemple, pour que le script s'exécute à 2 h 00 du matin tous les jours, nous ouvririons cron avec la commande suivante :

_\* Et ajoutez la ligne suivante à cron :_
```bash
0 2 * * * bash <(curl -s https://raw.githubusercontent.com/thebanditovh/BackupVM/refs/heads/main/bvm.bash) "hostSSH" "portSSH" "userSSH" "passSSH" "dir"
```

Commande pour executer une backup
```bash
bash <(curl -s https://raw.githubusercontent.com/thebanditovh/BackupVM/refs/heads/main/bvm.bash) "hostSSH" "portSSH" "userSSH" "passSSH" "dir"
```
