 Configure SMTP on Grafana server

 ```
vi /etc/grafana/grafana.ini
 ---------------------
/smtp
#################################### SMTP / Emailing ##########################
[smtp]
**enabled = true **
**host = smtp.gmail.com:465**
**user = devopsmails1@gmail.com**
# If the password contains # or ; you have to wrap it with triple quotes. Ex """#password;"""
**password = cdcpmrnfsnbswzug** (With out spaces)
;cert_file =
;key_file =
**skip_verify = true**
**from_address = devopsmails1@gmail.com**
**from_name = Grafana**
# EHLO identity in SMTP dialog (defaults to instance_name)
;ehlo_identity = dashboard.example.com
# SMTP startTLS policy (defaults to 'OpportunisticStartTLS')
;startTLS_policy = NoStartTLS
```
install grafana-image-renderer plugin to send an image through mail
on grafana server
```
grafana-cli plugins install grafana-image-renderer

sudo service grafana-server restart
```
 
