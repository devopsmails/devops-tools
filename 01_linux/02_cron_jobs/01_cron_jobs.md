What is Cron?

```
In Linux, a cron job is a scheduled task that automatically runs at a specific time or interval. It's like setting an alarm for your computer to do something instead of yourself!
```
CRON COMMANDS
```
service cron status or systemctl status cron    -  Shows cron status is active or not
service cron start              - must be active to set cron job
service cron stop
service cron restart
crontab -l                      - list set cronjobs  
crontab -e                      - To enter a crontab (ex: * * * * * echo "hello" >> output.txt) 
    > Crontab guru.com - helps creating cron expression
``` 
