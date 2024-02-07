error: 
```
ubuntu@ip-172-31-12-4:~$ vault server -dev -dev-listen-address=0.0.0.0:8200
Error parsing listener configuration.
Error initializing listener of type tcp: listen tcp4 0.0.0.0:8200: bind: address already in use
```
Sol:
```
ps aux | grep 8200      - lists all process connects to port 8200

If connected process with 8200 is needed then Change port IP & enter the same command
else kill the PID attached with port.
kill <PID>
Then Re-enter the cmd
```
