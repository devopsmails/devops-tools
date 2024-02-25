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
ANSIBLE VAULT COMMANDS
```
General:

ansible-vault: Get help on Ansible Vault commands.
ansible-vault --version: Display the Ansible Vault version.
Vault File Management:

ansible-vault create <file>: Create a new encrypted file.
ansible-vault edit <file>: Edit an existing encrypted file.
ansible-vault view <file>: View the decrypted contents of a file.
ansible-vault delete <file>: Delete an encrypted file.
String Encryption/Decryption:

ansible-vault encrypt_string "<string>": Encrypt a string.
ansible-vault decrypt_string "<string>": Decrypt a string.
Vault Password Management:

ansible-vault pass: Manage the vault password (set, change, list).
ansible-vault --ask-vault-pass: Prompt for the vault password during each command.
ansible-vault --vault-password-file <file>: Use a password file for vault operations.
Additional Options:

--vault-id: Specify a vault ID for multiple vaults.
--vault-password: Provide the vault password directly.
--help: Get help for specific commands.
```
