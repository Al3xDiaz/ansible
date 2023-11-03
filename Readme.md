# ANSIBLE
## Create env file

#### Note: you must replace the variables with the values ​​of your servers

```bash
# create basic inventory
cat ansible/inventory || echo -e "[all]
$(hostname -I | awk '{print $1}') ansible_user=$USER server_ssh_key_passphrasse=\"\" server_gpg_passphrasse=\"\"
[localhost]
$(hostname -I | awk '{print $1}') ansible_user=$USER server_ssh_key_passphrasse=\"\" server_gpg_passphrasse=\"\"
[all:vars]
ansible_ssh_pass=\"\"
ansible_sudo_pass=\"\"
git_name=johndoo 
git_email=john@doo.es
[personal:children]
localhost" > ./ansible/inventory
```

```bash
# ansible desencrypt inventory
ANSIBLE_VAULT_PASSWORD_FILE=.vault_pass.txt
ansible-vault decrypt inventory
```

```bash
# ansible desencrypt inventory
ANSIBLE_VAULT_PASSWORD_FILE=.vault_pass.txt
ansible-vault encrypt inventory
```

## Build image

```bash
docker-compose build
```

## Test Playbooks

```bash
docker-compose up
```

## Commands available

```bash
# install ansible on Debian
sudo apt-get install ansible
```

```bash
### Ping all host
# Note: if ping is UNREACHABLE! or Failed to connect to...
# copy content by ./ansible/ssh-keys/ansible.pub in file ~/.ssh/authorized_keys in your server.
docker-compose run  --rm ansible ansible all -m ping
```

```bash
# Copy identity file 
# Note: you can replace "node-`hostname -I | awk '{print $1}'`" for your $HOST_NAME or $IP_ADDRESS
docker-compose run --rm ansible ssh-copy-id -i /root/.ssh/ansible node-`hostname -I | awk '{print $1}'`
```

```bash
#list all hosts
docker-compose run --rm ansible ansible all --list-hosts
```

```bash
#add ssh key to host
docker-compose run --rm ansible ansible-playbook playbooks/01_copy_ssh_key.yml
```

## Run playbooks

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/configSystem.yml --check
```

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/devtools.yml --check
```

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/docker.yml --check
```

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/htopPlaybook.yml --check
```

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/interface.yml --check
```

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/interpreters.yml --check
```

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/k8-master-node.yml --check
```

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/k8-nodes.yml --check
```

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/k8-workers-node.yml --check
```

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/nginx.yml --check
```

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/testInclude.yml --check
```

## link config files to host

```bash
rm ~/.tmux.*
rm ~/.bash_aliases
ln -s `pwd`/files/.tmux.conf ~/.tmux.conf
ln -s `pwd`/files/.bash_aliases ~/.bash_aliases
tmux new source-file ~/.tmux.conf
```

### Generate GPG key

```bash
EMAIL=$(git config --global user.email)

echo "writte your email [$EMAIL]]"
read YOUR_EMAIL
[[ "$YOUR_EMAIL" == "" ]] && YOUR_EMAIL=$EMAIL

echo "writte your password for gpg key:"
read PASSPHRASE

#Generate key
gpg --batch --gen-key <<EOF
Key-Type: 1
Key-Length: 4086
Subkey-Type: 1
Subkey-Length: 2048
Name-Real: $(git config --global user.name)
Name-Email: $YOUR_EMAIL
Passphrase: $PASSPHRASE
Expire-Date: 1y
EOF

gpg --list-secret-keys --keyid-format LONG $YOUR_EMAIL

#Export key
KEY_ID=$YOUR_EMAIL
gpg --armor --export $KEY_ID


```
