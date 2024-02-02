diff b/w git fetch & git pull?
----
```
Git fetch: 
    > get the changes from remote to local & doesn't merge. Used for preview change & merge if required
git pull: Get & merges the changes from remote to local repo. Useful for quick updates merge
```

Creating
adding
modifying
----------
2.Every Code change repetitions:
----------------
git add #
git commit -m ""
git push -u origin master/branch name
---------------
Git Commands:
==========
 Go to the folder >> open git bash
git --version                           -     Shows the git version if it's installed
echo "#learninggit" >> readme.md        -     Creates readme.md and add to a line in it
ls -la                                  -     lists all the files
git init                                -     Initializes & creates .git file
ls
history                                 -     lists the commands used
git status                              -     show status of the file at working area
git add .\readme.md                     -     adding the file from working to staging area
git commit -m "First Commit"            -     adding discription for the code change
git branch                              -     Shows Current branch name
git remote -v                           -     Shows which remote repo we are currently on
git remote add origin https://github.com/devopsmails/temp.git
                                        -     adding the remote url to fetch or push the changes
git branch                        
git push -u origin master               -     Pushing the current changes to remote master origin url
git remote -v
git add .                               -     "." allows to add all the files in current directory
-------------
Git Branching
------------
git branch                              -     Shows the current branch name
git branch feature                      -     Creates new branch named feature
git checkout feature                    -     Switches current branch to feature branch
git checkout -b bugfix                  -     Creates a new branch & switches to that branch
#2
git push -u origin feature              -     Adds the current files to Feature branch
------------
git Merging
-----------
Helps to combine two or more developers code to master branch

Merging on git hub GUI:
----------------------
pullrequests >> "master <- feature" >> click on pull request >> merge rquest >> confirm merge

===============

git clone repo https url                   - If want to get all the files of a repo >> github >> repo >> code                                              >>https link >> copy paste 
                                           - To get all the files from repo to a server for making the                                                     changes:

------------------
pushing from Ec2 or other server:
------------
git config --global --user.name "suresh"  - To push from the different server need config user name 
git config --global --user.email "devopsmails@gmail.com"
                                          - To push from the different server need config user mail
--------------
git game is also avilable free online
