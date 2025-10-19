Utilisez cron pour planifier des sauvegardes
Par exemple, pour que le script s'exécute à 2 h 00 du matin tous les jours, nous ouvririons cron avec la commande suivante :
```bash
$ crontab -e
```
Et ajoutez la ligne suivante à cron :
```bash
0 2 * * * bash <(curl -s https://raw.githubusercontent.com/thebanditovh/BackupVM/refs/heads/main/bvm.bash) "host" "user" "pass" "dir"
```

Exec bash
```bash
bash <(curl -s https://raw.githubusercontent.com/thebanditovh/BackupVM/refs/heads/main/bvm.bash) "host" "user" "pass" "dir"
```
