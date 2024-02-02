Version control system: 
```
   Sharing code: possible to share code with multiple users
   Versioning: easy to rollback or rollout & track the changes
```
SVN VS GIT: 
```
SVN:
  > follows Centralized system.
  > Where we should push & pull the code  from only central server
  > no way for developers  to communicate with each other's code when svn server goes down
GIT:
  > follows Distributed system.
  > Where we should push & pull the code  from only central server
  > Git allows to take n number of copies required(Fork) as a back up for centralized server
```
What is Git & Github?
```
git:
  > Open source
  > on EC2 server installs git asked devlopers to commits git only
  > no UI, Difficult for reviewing, issues tracking, Usability

github:
  > UI enaled, easy code reviewing, issues tracking, usability
Hosting platform
Collaboration features
Social coding platform
```
GIT BRANCH:
-----
```
To add new features to main/master (branch) code more secure & effective use the branches
   > First creates a new branch called v2/feature. then code & test. then merge with main branch
```
Git Branching Strategy
----------------
```
master branch: always update
feature branch: new feature want to add
release branch: release app to customer from this branch
hot fix branch: error fixing
```
Git commands
```
git install
git init
mkdir app.com
cd app.com
vi calculator.sh(x=a+b)
git add .
git commit
git push -u origin main
vi calculator.sh(x=a+b+c)
git diff
git logs
git reset --hard #commit id - to go back to previous version
cat calculator.sh  
```
