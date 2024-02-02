What is ansible playbook?

```
Ansible playbook list of task written in YAML to execute on host or target servers
```

Why ansbile-playbooks?

```
To perfom multiple task on any number or group of hosts
```

Ansible server:
-----------
```
mkdir dev_playbooks
cd dev_playbooks

Example
vi nginx_start_install.yaml
--------------
---
- name: installing nginx & starting
  hosts: all
  become: yes
  tasks:
    - name: install nginx -a
      apt:
        name: nginx
        state: present
    - name: start nginx -b
      service:
        name: nginx
        state: started
--------------
cmd:
----
ansible-playbook -vvv -i /home/ubuntu/ansible/inventory nginx_install_start.yaml
    -vvv = For debugging it showss what ever ansible doing to a playbook from start end we can view terminal
    ansible-playbook = Key word run ansible playbooks
    -i /home/ubuntu/ansible/inventory = path to inventory 
    nginx_install_start.yaml = playbook to get executed

output:
systemctl status nginx (shows active and running on target server)
```
