What is shell script?

Consist a set of commands to perform a task.
It's an interface betwwen user and OS kernal.
All the executes sequentially.
Some tasks like file manipulations, Program Executions, User interactions, Automation Tasks can be done. 
===================================  

Advantages of shell Script?

 Can Aviod Repetative tasks
     Keeps history of config
     Share the instructions with others to do the same.
     logic & Bulk Operations
============================
Advantages of writing shell script in a file?
==========================
File is movable
        copy
        share
        store

=========================
What is Shell Script?
====================
 A file that contains bunch of linux commands
 can write more complex code in it
 It has ".sh" Extenstion for it

======================
Types of Shells?
====================
Bourne Shell
Bourne Again Shell
Korn Shell
C Shell
Tcsh Shell
===========================
Different shell implemetaions
========================
shell(bourne shell)                                           bash(bourne again shell)
/bin/sh                                                       /bin/bash
old default version along with OS                             Current default version along with OS
=================================

what is #!/bin/bash ? (shebang)
used to instruct the operating system to use bash as a command interpreter. 

Commands:
========

PWD                                : Present Workind Directory
ls -lrt                            : List all the directories including hidden
echo $0                            : Shows the which shell it's using as 
touch var.sh                       : Only cretes the file
ls /bin/bash                       : lists all the files in on bash directory if it has any

====================
Creating Variables:
===========

vi Var.sh                           : vi = editor & creates & opens a file var.sh

#!/bin/bash

name=suresh
youtube=cinemacommunity

ls -lrt                            : lists file with permissions
chmod u+x var.sh                   : Gives the executable permisssion
./ var.sh                          : Execute the command in the file var.sh
sh var.sh                          : Execute the command in the file var.sh
cat var.sh                         : view the file info


Dynamic Variables: Taking the input from the User & take as a variable
=================
vi read.sh

echo Enter your name:
read name
echo hi i am $name and this is dynmic variable values assigning


echo                               : Print the value
read                               : Read the value assigned
chmod u+x read.sh                  : Gives the executable permisssion
./ read.sh                        

output:
------

Enter your name:                  (We'll Enter the input)
Suresh
hi i am Suresh and this is dynmic variable values assigning
    ------------

Types of Operators:
==================
      an operator is a character that represents a specific mathematical or logical action or process.

-eq       : Equals to                       ex: [ $a -eq $b ] when a & b are equals
-nq       : not equals to                   ex: [ $a -nq $b ] when a & b are not equals
-gt       : Greater than                    ex: [ $a -gt $b ] when a is greater than b value
-lt       : Lesser than                     ex: [ $a -lt $b ] when a is lesser than b value
-ge       : Greater than or Equals to       ex: [ $a -ge $b ] when a is greater than or equals to b value
-le       : Lesser Than or Equals to        ex: [ $a -le $b ] when a is lesser than  or equal to b value

If-Else:
========
    Use if to specify a block of code to be executed, if a specified condition is true. 
    Use else to specify a block of code to be executed, if the same condition is false.
    Use else if to specify a new condition to test, if the first condition is false.

  vi ifelse.sh

  #!/bin/bash

  a=10
  b=20
  if [$a > $b]
  then
     echo "a is greater than b"
  else
     echo "b is greater than a"
  ------------------or---------------

echo Enter your age to check Vote Eigibilty:
read age
if [ $age -ge 18 ]
then
   echo $age is eligible to vote!
else
   echo $age not eligible to vote!
fi
--------
sh ifelse.sh 

output:
------
Enter your age to check Vote Eigibilty:
6
6 not eligible to vote!
--------------



vi swithcase.sh
-----------

echo Make your Choice!
echo
echo a=To see the date today!
echo b=To list all the files in Current Working Directory!

read choice

case $choice in
        a)date
        b)ls -ltr
        *)echo Invalid input!
esac  
--------------

switch case:
===========
    A case construct helps us to simplify nested if statement.
vi switchcase.sh

#!/bin/bash

echo Make your Choice!
echo
echo a=To see the date today!
echo b=To list all the files in Current Working Directory!

read choice

case $choice in 
        a)date ;;
        b)ls -ltr ;;
        *)echo Invalid input!
esac

-----Output--------
ubuntu@ip-172-31-40-20:~$ sh switchcase.sh 
Make your Choice!

a=To see the date today!
b=To list all the files in Current Working Directory!
b
total 16
-rwxrw-r-- 1 ubuntu ubuntu 103 Jul 20 12:25 var.sh
-rwxrw-r-- 1 ubuntu ubuntu 109 Jul 20 12:35 read.sh
-----------------------

For Loop:
================
     The for loop operate on lists of items. It repeats a set of commands for every item in a list. 

vi forloop.sh

#!/bin/bash

for i in {1..10}; do
  echo $i
done

result:
1
2
3
4
5
6
7
8
9
10
--------------or----------------

for i in $(seq 1 20)
do
  echo number $i
done
-------------output---------
number 1
number 2
number 3
number 4 (....till number 20)

-----------------
While Loop:
===========
        
    The while loop enables you to execute a set of commands repeatedly until some condition occurs. 
    It is usually used when you need to manipulate the value of a variable repeatedly.
    
vi whileloop.sh

#!/bin/bash

count=0
num=10

while [ $count -le $num ]
do
  echo number $count
  count=$(expr $count + 1)
done

-----------output----------
    
number 0
number 1
number 2 (..till 10)
-----------------
Iterrating:
============
     Bash iteration statements are simply the repetition of a process within a shell script. 
     Getting the values from one file to another. 
vi name.sh or name

Suresh
Ramesh
Rakesh
Mohan

vi iterrate.sh

#!/bin/bash

names="/home/ubuntu/name.sh"

for name in $(cat $names)
do
  echo $name
done
----
sh iterrate.sh
----output-----
Suresh
Ramesh
Rakesh
Mohan

But when we cat the file be the same only the out changes. 
    


