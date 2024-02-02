Role: DevOps Build & Release Engineer   
--------------------------------
1. What is DevOps life Cycle?
   ========================
![image](https://github.com/devopsmails/devops/assets/119680288/70ad82bc-d87c-4320-8700-83c18116b921)

2.What are the Day-to-Day activities of a DevOps Engineer?
=========================================================
```
Automate software development and deployment using AWS services & few open source tools. 
Manage AWS infrastructure, including EC2, EBS, IAM. VPC, LAMBDA, ROUTE53, SNS, Autoscalling, Load Balancing and S3
Monitor and troubleshoot AWS applications and infrastructure. 
Collaborate with development and operations teams to improve the software development and delivery process
Implement and maintain security measures for AWS applications and infrastructure(SG, VPC, VFW, k8 RBAC)
Optimize AWS infrastructure for performance and cost
Stay up-to-date on the latest DevOps technologies.
Work on complex and challenging DevOps projects
Design and implement new DevOps solutions
Automate and optimize existing DevOps processes
```
GIT & GITHUB 
--------------
3. CURL VS WGET?
4. git clone vs pull vs fetch vs fork?
   ===================================
Use git clone to:  
--------------
Create a local copy of a remote repository for the first time.  
Create a local copy of a remote repository that you want to work on independently.  

Use git pull to:
--------------
Update your local repository with the latest changes from the remote repository.  
Merge changes from the remote repository into your current branch.  

Use git fetch to:  
------------------
Get the latest changes from the remote repository without merging them into your current branch.  
See what changes have been made to the remote repository since your last pull.  

Use git fork to: 
----------------
Create a copy of a remote repository on your own GitHub account.  
Make changes to a project without affecting the original repository.  

5. Git merge vs rebase?
--------------
| git merge | Creates a new commit that merges the changes from the two branches. |  
| git rebase | Replays the commits from one branch on top of another branch. |  

Use git merge when:  
-----------------
You want to preserve the history of the two branches.  
You are working on a team and you need to integrate your changes with the changes of other team members.  

Use git rebase when:  
-----------------
You want to have a clean and linear history.  
You are working on a personal project and you don't need to share your changes with anyone else.  

6. Git reset vs revert vs cherrypick:
--------------------------------
Use git reset when:  
-----------------
You want to undo all of the changes that have been made since a previous commit.  
You have made a mistake and you want to go back to a previous state of your repository.  

Use git revert when:  
-----------------------
You want to undo the changes made in a previous commit, but you don't want to change the history of your repository.  
You want to create a new commit that undoes the changes made in a previous commit.   

Use git cherry-pick when: 
---------------------
You want to redo changes that have been undone.  
You want to apply changes from one branch to another branch.  
It is important to note that git reset is a dangerous command if you have already shared your changes with others. This is because git   reset can rewrite the history of your commits, which can make it difficult for others to merge your changes into their own branches.  
