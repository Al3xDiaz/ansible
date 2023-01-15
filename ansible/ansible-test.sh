#! /bin/sh
#without pass
ansible-playbook playbooks/configSystem.yml --syntax-check
ansible-playbook playbooks/testInclude.yml --syntax-check

#become pass
ansible-playbook playbooks/devtools.yml --syntax-check
ansible-playbook playbooks/htopPlaybook.yml --syntax-check
ansible-playbook playbooks/interface.yml --syntax-check
ansible-playbook playbooks/interpreters.yml --syntax-check

##kubernetes 
ansible-playbook playbooks/k8-master-node.yml --syntax-check
ansible-playbook playbooks/k8-workers-node.yml --syntax-check
ansible-playbook playbooks/k8-nodes.yml --syntax-check

## devops
ansible-playbook playbooks/nginx.yml --syntax-check
ansible-playbook playbooks/docker.yml --syntax-check