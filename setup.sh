#! /bin/sh
alias ll="ls -l"
alias la="ls -A"
alias l="ls -CF"
alias lll="ls -l | less"
cp /home/.ssh/ansible /root/.ssh/ansible
chmod 600 /root/.ssh/ansible
cp /home/.ssh/ansible.pub /root/.ssh/ansible.pub

if [ ! -f /root/.ssh/ansible ]; then
    ssh-keygen -b 3072 -t rsa -f /root/.ssh/ansible -q -N '' -C ansible
fi
chown root /root/.ssh/*
exec $@