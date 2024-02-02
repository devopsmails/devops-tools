```
sudo -i
apt update -y
apt upgrate -y
apt install ufw
systemctl status ufw                -  active running
ufw default allow outgoing          -  allow outgoin to internet
ufw default deny incoming           -  Denies the incoming
ufw allow ssh                       -  allows the ssh
ufw status                          -  (inactive now)
ufw enable                          -  makes it to implement changes done above
ufw status                          -  (active now)
ufw allow http/tcp                  -   Allows HTTPS/TCP  
ufw status numbered                 -   Gives the status with the numbered
ufw delete 1                        -   Deletes the number 1
https://icanhazip.com/              -   Provides public ip(2409:408c:3e8d:c7ae:7104:1717:7673:6bc5)
ufw allow from 2409:408c:3e8d:c7ae:7104:1717:7673:6bc5 to any port 22 proto tcp   allows only the ip
```
