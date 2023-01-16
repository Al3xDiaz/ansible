# ANSIBLE
## Create env file

#### Note: you must replace the variables with the values ​​of your servers

```bash
echo -e "[all]
$(hostname -I | awk '{print $1}') ansible_user=$USER server_ssh_key_passphrasse=\"\"\n
[localhost]
$(hostname -I | awk '{print $1}') ansible_user=$USER server_ssh_key_passphrasse=\"\"\n
[all:vars]
git_name=johndoo git_email=john@doo.es\n

[personal:children]
localhost" > ./ansible/inventory
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

## Run playbooks

```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/configSystem.yml --ask-become-pass
```
```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/devtools.yml --ask-become-pass
```
```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/docker.yml --ask-become-pass
```
```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/htopPlaybook.yml --ask-become-pass
```
```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/interface.yml --ask-become-pass
```
```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/interpreters.yml --ask-become-pass
```
```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/k8-master-node.yml --ask-become-pass
```
```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/k8-nodes.yml --ask-become-pass
```
```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/k8-workers-node.yml --ask-become-pass
```
```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/nginx.yml --ask-become-pass
```
```bash
#test
docker-compose run --rm ansible ansible-playbook playbooks/testInclude.yml --ask-become-pass
```

## link tmuxconfig to host

```bash
rm ~/.tmux.*
ln -s `pwd`/ansible/files/.tmux.conf ~/.tmux.conf
ln -s `pwd`/ansible/files/.tmux.git.conf ~/.tmux.git.conf
tmux source-file ~/.tmux.conf
```
