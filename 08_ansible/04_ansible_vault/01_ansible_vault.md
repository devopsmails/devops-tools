```
ansible-playbook(vault)	" ---
name: clining the git repo
become: yes
hosts: all
vars_files:
 - vault-pass.yml#where password is saved
tasks:
  -name: clone a repo
   git:
      repo:https://githubusername:githubpassword@github.com/devopssuresh1/Maven_Project.git #repo:https://devopssuresh:{{password}}@github.com/devopssuresh1/Maven_Project.git
dest:/opt/ansibleadmin/maven-demo"

"vi vault-pass.yml
password = Suresh@123"

```
