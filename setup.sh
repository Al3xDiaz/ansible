#! /bin/sh
alias ll="ls -l"
alias la="ls -A"
alias l="ls -CF"
alias lll="ls -l | less"
if [ ! -f /home/user_keys/ansible ]; then
    ssh-keygen -b 3072 -t rsa -f /home/user_keys/ansible -q -N '' -C ansible
else
    cp /home/user_keys/ansible /root/.ssh/ansible
    chmod 600 /root/.ssh/ansible
    cp /home/user_keys/ansible.pub /root/.ssh/ansible.pub
fi
chown root /root/.ssh/*
exec $@