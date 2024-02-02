hostname -i             - shows private ip of server
 
Linux AWS EC2 Ubuntu system logs:
---------

To view the most recent system logs, you can simply use the following command:
```
journalctl
````

You can see more or fewer entries by specifying a number with the -n option. 
```
journalctl -n 200
```
You can filter the logs by specifying a system service or application with the -u option. 
```
journalctl -u jenkins
```
You can also filter the logs by date and time with the -b option
```
journalctl -b -1
```
And you can filter the logs by log level with the -p option. 
```
journalctl -p err
```
You can combine multiple filters to narrow down the logs even further
```
journalctl -p err jenkins -b -1
```
To follow the logs as they are written, you can use the -f option:
```
jouralctl -f
```
You can save the logs to a file with the -o option:
```
journalctl -o cat > /path/to/file.log
```
System Logs:

```
/var/log/messages: 
This is the main system log file and contains messages from various system services and applications.

/var/log/syslog:
/var/log/kern.log:
/var/log/auth.log:
/var/log/dmesg: This file contains kernel boot messages.
```
Application Logs:
The location of application logs will depend on the specific application. Some common locations include:
```

/var/log/<application_name>.log: This is a common location for application logs.
<application_installation_directory>/logs: Many applications store their logs in a subdirectory called logs within their installation directory.
/var/lib/<application_name>/logs: Some applications store their logs in a dedicated directory within the /var/lib directory.
```
Other Log Locations:
```
/etc/syslog.conf: This file contains configuration settings for the syslog service, which is responsible for managing system logs.
/var/log/audit/audit.log: This file contains audit logs, which track user activity and system events.
```
