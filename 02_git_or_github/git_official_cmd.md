Git-Book_o: https://git-scm.com/book/en/v2  
O-Docs:  https://git-scm.com/docs/giteveryday  >> Topics  


Git installation: 
-----------------
Git would be installed defaultly on AWS Instance.
```
git -v                                                            - Shows git version  
git --version  

git -h                                                            - shows the list of regular commands  
git -help  
```
1.Setup and Config:  
----------------

Git is a fast, scalable, distributed revision control system with an unusually rich command set that provides both high-level operations and full access to internals.  

commands:  
----------

git config: 
---------
The git config command is used to set or display Git configuration options.   
It can be used to configure Git globally, for the current repository, or for a specific branch.   
sy:   
git config <scope>.<key> <value>  

scope can be one of the following: --global, --local, or --branch.  
key: is the name of the configuration option.  
value:  is the value for the configuration option.  

# Set the global user name and email address:  
```
git config --global user.name "Suresh"  
git config --global user.email suresh@gmail.com  
```
Git Help:  
-------
```
git help
- To get general help

git help <command>
 - to get help command wise like: git help commit

git help branching
 - To get help on specific topic
```

2.Getting and Creating Projects:  
---------------

Getting a repo:  
---------------
```
ex: $ cd /home/user/my_project
- to track or control my_project with git should be on the folder  

git init
- It can be used to create a new repository from scratch, or to convert an existing directory into a Git repository.
- create a new """.git""" directory in the current directory. The .git directory contains all of the metadata that Git needs to track your changes.    
```
Cloning a repo:     
----------------
- clone an existing Git repository to your local machine.  
- This means that it will create a copy of the remote repository on your local machine, including all of the files, branches, and commits.  
```
git clone <URL of the remote repository>  
```
3.Basic Snapshotting:
---------------------

git add:
----
- To add files to the staging area.      
- The staging area is a temporary area where you can stage your changes before committing them to the local repository.  
```
git add <file>  
git add README.md
- To add a file

git add README.md LICENSE.md
- To add multiple files

git add .
- To add all untracked files
```
Git status:  
---------
- To display the status of the working directory and the staging area.
- It shows which files have been modified, which files have been staged, and which files are untracked.
```
git status  
- Display the status of the working directory and the staging area.  

git status -v   
- Display a diff of the modified files.  

git status -b   
- Display the status of all of the branches in the repository. 
```
Git diff:  
----------
- To show the difference between two files, two commits, or two branches.
- This can be useful for seeing what changes have been made to a file, or for debugging problems with your repository.
```
git diff <file1> <file2>
git diff <branch1> <branch2>

```

git commit:
-----
- To commit the changes in the staging area to the local repository.
- This creates a new snapshot of your repository, which you can then share with others or push to a remote repository.

```
git commit -m "Added README file" README.md

git commit -a
- if you have staged multiple files and you want to commit them all at once
```
git notes:  
-----------
- add extra information to a commit without changing the commit message or modifying the history of the commit.  
```
git notes add -m "<note message>" <commit hash>
git notes add -m "This commit fixes the bug in the login page" 1234567890abcdef

git notes show <commit hash>  
git notes show 1234567890abcdef
```
git resore:  
-----------
- To restore files and directories to their previous state.
- This can be useful for recovering from accidental deletions or changes.
```
(rm S:\Devops\downloading_files_temp\Git\test\test\file2.txt)
git restore <file or directory path>
git restore README.md

git restore -r 1234567890abcdef README.md
- To recover it to specific commit

git restore .
- To restore all deletions
```
git reset:  
-----------
- To move the HEAD pointer back to a specified commit.    
- This will discard all of the uncommitted changes in the working directory, as well as any commits that were made after the specified commit.
  
There are three different types of git reset:   

git reset --soft:   
- This will move the HEAD pointer back to a specified commit, but it will not discard any of the uncommitted changes in the working directory.
  
git reset --mixed:   
This is the default type of git reset. It will move the HEAD pointer back to a specified commit and discard all of the uncommitted changes in the working directory.  

git reset --hard:   
This will move the HEAD pointer back to a specified commit and discard all of the uncommitted changes in the working directory,   
as well as any commits that were made after the specified commit.  
```
git reset HEAD  
- Discard all of the uncommitted changes in the working directory, and move the HEAD pointer back to the last commit

git reset 1234567890abcdef   
- Discard all of the uncommitted changes in the working directory, and move the HEAD pointer back to the commit with the hash 1234567890abcdef  

git reset --hard 1234567890abcdef
- Discard all of the uncommitted changes in the working directory, and move the HEAD pointer back to the commit with the hash 1234567890abcdef, and discard all of the   
  commits that were made after that commit  
```
git rm:
---
- Removes the mentioned files.  
```
git rm myfile.txt                           - remove 1 file    

git rm myfile.txt myotherfile.txt           - removes multiple files    

git rm *.txt                                - removes all the files ends with "".txt""  

git rm -r  filedir                          - removes directory recursively  
```
git mv:  
------
- Moves or renames
```
git mv myfile.txt subdir                     - Move a file from one directory to another  
git mv myfile.txt newfile.txt                - Rename a file  
git mv mydir subdir                          - Move a directory and all of its contents to another location  
git mv mydir newdir                          - Rename a directory
```
