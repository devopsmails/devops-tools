env_var_linux:
----
```
env                     - lists envs
env | grep VAULT        - can grep a var

```
newgrp #groupname (kubnertes/docker/ubuntu) - Reboots the group info
sudo mv helmfile /usr/local/bin         - to run from anywhere in the terminal
space > helmfile.yaml       - clears the complete file info
 ```
decoding command:
```
echo dWFnandld0FjdUp1MjQwOQ== | base64 --decode
```

networking:
------
```
netstat -tnlpu             - To know the ports used
ss -tnlpu                  - more advanced to know the ports are used


ps                         - list the running services
kill -9 PID                - Kills immediatly


sudo hostnamectl set-hostname JENKINS-SERVER    - To change the hostname to Jenkins_server   
sudo systemctl reboot                           - To reboot the system  
find / -name java-11*                           - To find the path of a file  
source .bash_profile                            - Update the changes to a file  

COPY:  
--
Secure Copy from local to remote server:  
scp  -i /Users/sures/Downloads/key1.pem /Users/sures/Downloads/key1.pem ubuntu@54.234.208.15:/home/ubuntu  
    (Key must be as chomod 0600 #key.pem)

Linux archetecture:
----------------
uname -m  = To find what archetecture using xrm64 or arm 64

SSH:  
---  
ssh -i #key.pem ubuntu@#publicip or Private ip   


NODE:
----
df - disk free
nproc - shows how many processors are in the instance
free - show memory detials
top - What are the processors running, causing more usage of memory..


process:
-------
ps -df - lists all the running process in a running format
ps -df | grep "amazon or ###" - lists only related to amazon

pipe(|) - pipe sends the first command output second command
-----
ps -df | grep "amazon or ###" - lists only related to amazon
vi test.sh
----
echo 1
echo 11
echo 12
echo 59
echo 60

./test.sh | grep 1
result: 
--------
1
11
12

AWK:
--
ps -df |grep "amazon" | awk -F " " '{print $1}'    - print all the process name with amozon of column 1  

Logfiles:
--------
cat /var/log/syslog | grep "error" - shows only the log files filterd with error from syslog

curl: to Retrive the info from internet or URL & doesn't save
--
curl https://us-east-1.console.aws.amazon.com/ec2-instance-connect/ssh?connType=standard&instanceId=i-05b0d00d364ba627d&osUser=ubuntu&region=us-east-1&sshPort=22#/ 
| grep "error"  


wget - Downloads the file & store the file
---
wget https://github.com/devopsmails/devops/edit/main/linux/Commands.md #download the commands.md file & store it

man - to view the details info of any command
----
man cat
man grep

find - Helps to file from huge number of files with the name
-----
find / -name pam.d

Kill - terminate the process
------

kill -p #name of the process

trap - Commands trap the specific signal type
--------
trap "echo don't use the ctrl+c" SIGINT - if any body press ctrl+c in the process of execution. it 'll pop the message. 
trap "rm -rf" #SIGINIT  - "initialize from starting"

1) System
uname	 Displays  Linux system information
uname -r	Displays  kernel release information
uptime	Displays how long the system has been running including load average
hostname	Shows the system hostname
hostname -i	Displays the IP address of the system
last reboot	Shows system reboot history
date	Displays current system date and time
timedatectl	Query and change the System clock
cal	Displays the current calendar month and day
w	Displays currently  logged in users in the system
whoami	Displays who you are logged in as
man	Used to help about that command

3) Hardware
dmesg	Displays bootup messages
cat /proc/cpuinfo	Displays more information about CPU e.g model, model name, cores, vendor id
cat /proc/meminfo	Displays more information about hardware memory e.g. Total and Free memory
lshw	Displays information about system’s hardware configuration
free -m	Displays free and used memory in the system (-m flag indicates memory in MB)
lspci -tv	Displays PCI devices in a tree-like diagram
lsusb -tv	Displays USB devices in a tree-like diagram
dmidecode	Displays hardware information from the BIOS
4) Users
id	Displays the details of the active user e.g. uid, gid, and groups
last	Shows the last logins in the system
who	Shows who is logged in to the system
groupadd “admin”	Adds the group ‘admin’
adduser “Sam”	Adds user Sam
userdel “Sam”	Deletes user Sam
usermod	Used for changing / modifying user information
5) File Commands
ls -al	Lists files – both regular &  hidden files and their permissions as well.
pwd	Displays the current directory file path
mkdir ‘directory_name’	Creates a new directory 
rm file_name	Removes a file
rm -f filename	Forcefully removes a file
rm -r directory_name	Removes a directory recursively
rm -rf directory_name	Removes a directory forcefully and recursively
cp file1 file2	Copies the contents of file1 to file2
cp -r dir1 dir2	Recursively Copies dir1 to dir2. dir2 is created if it does not exist
mv file1 file2	Renames file1 to file2
ln -s /path/to/file_name   link_name	Creates a symbolic link to file_name
touch file_name	Creates a new file
cat > file_name	Places standard input into a file
more file_name	Outputs the contents of a file
head file_name	Displays the first 10 lines of a file
tail file_name	Displays the last 10 lines of a file
gpg -c file_name	Encrypts a file
gpg -d file_name.gpg	Decrypts a file
wc	Prints the number of bytes, words and lines in a file
xargs	Executes commands from standard input
6) File Permission
chmod octal filename        	Change file permissions of the file to octal
Example	 
chmod 777 /data/test.c      	Set rwx permissions to owner, group and everyone (everyone else who has access to the server)
chmod 755 /data/test.c      	Set rwx to the owner and r_x to group and everyone
chmod 766 /data/test.c       	Sets rwx for owner, rw for group and everyone
chown owner user-file        	Change ownership of the file
chown owner-user:owner-group file_name      	Change owner and group owner of the file
chown owner-user:owner-group directory  	Change owner and group owner of the directory
7) Network
ipaddress show                   	Displays IP addresses and all the network interfaces
ifconfig                            	Displays IP addresses of all network interfaces
ping  host                       	ping command sends an ICMP echo request to establish a connection to server / PC
whois domain                 	Retrieves more information about a domain name
dig domain                      	Retrieves DNS information about the domain
dig -x host                   	Performs reverse lookup on a domain
host google.com          	Performs an IP lookup for the domain name
hostname -i                     	Displays local IP address
wget file_name            	Downloads a file from an online source
netstat -pnltu     	Displays all active listening ports
8) Compression/Archives
tar -cf home.tar home<:code>	Creates archive file called ‘home.tar’ from file ‘home’
tar -xf files.tar             	Extract archive file ‘files.tar’
tar -zcvf home.tar.gz source-folder   	Creates gzipped tar archive file from the source folder
gzip file 	Compression a file with .gz extension
9) Install Packages
rpm -i pkg_name.rpm           	Install an rpm package
rpm -e pkg_name                     	Removes an rpm package
dnf install pkg_name	Install package using dnf utility
10) Install Source (Compilation)
./configure	Checks your system for the required software needed to build the program. It will build the Makefile containing the instructions required to effectively build the project
make	It reads the Makefile to compile the program with the required operations. The process may take some time, depending on your system and the size of the program
make install	The command installs the binaries in the default/modified paths after the compilation
11) Search
grep ‘pattern’ files                           	Search for a given pattern in files
grep -r pattern dir                             	Search recursively for a pattern in a given directory
locate file                                           	Find all instances of the file
12) Login
ssh user@host                                        	Securely connect to host as user
ssh -p port_number user@host     	Securely connect to host using a specified port
ssh host                                               	Securely connect to the system via SSH default port 22
telnet host 	Connect to host via telnet default port 23
13) Disk Usage
df  -h                           	Displays free space on mounted systems
df  -i                          	Displays free inodes on filesystems
fdisk  -l                    	Shows disk partitions, sizes, and types
du -sh                       	Displays disk usage in the current directory in a human-readable format
findmnt                      	Displays target mount point for all filesystems
mount device-path mount-point	Mount a device
14) Directory Traverse
cd ..             	Move up one level in the directory tree structure
cd                	Change directory to $HOME directory
cd /test 	Change directory to /test directory
15) GREP
‘grep’ command stands for global regular expression print

grep value filename        	To search a value
grep -v value filename	To ignore the value
grep -i  value filename	To search the value  
Cat filename | grep value	To search the value on file
15) SED
Linux ‘sed’ command stands for stream editor.

sed ‘=’ filename                                    	To print line numbers with content
sed -n ‘5,9p’ filename    	To print 5 to 9 lines
sed ‘5,9p’ filename	To paste 5 to 9 lines
echo abc | sed ‘s/abc/def/’         	To replace abc with def  
sed -e ‘s/abc/def/; s/def/ghi/’ file         	To replace multiple things
sed ‘3c\changed’ filename	To change the 3rd line
```
debian PKG:
-----
```
Installing Debian PKG:
    wget -O splunk-9.1.1-64e843ea36b1-linux-2.6-amd64.deb "https://download.splunk.com/products/splunk/releases/9.1.1/linux/splunk-9.1.1-64e843ea36b1-linux-2.6-amd64.deb"
unpackage debian  
sudo dpkg -i splunk-9.1.1-64e843ea36b1-linux-2.6-amd64.deb
```
UFW = Instance firewall defaultly installed  on AWS ec2 ubuntu 
------------
```
sudo ufw allow openSSH
sudo ufw allow 8000
sudo ufw status
sudo ufw enable
sudo ufw status
```
