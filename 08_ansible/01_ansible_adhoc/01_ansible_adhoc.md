What is ansible Adhoc commands?
```
To run simple cli commands no need to write playbooks. We can use Adhoc commands
```

Adhoc commands:
--------------
```
ansible -i inventory all -m "shell" -a "touch devops_demo"
    - all = all target servers creates the files
    - (-m) = modules ###*****https://docs.ansible.com/ansible/2.9/modules/list_of_all_modules.html
    - (-a) = Adhoc
ansible -i inventory all -m "shell" -a "df"
ansible -i inventory all -m "shell" -a "nproc"
ansible -i inventory web_servers -m "shell" -a "rm devops_demo"
    - web_servers = grouped servers in inventory
```
