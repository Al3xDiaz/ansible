#! /bin/sh
alias ll="ls -l"
alias la="ls -A"
alias l="ls -CF"
alias lll="ls -l | less"
if [ ! -f /root/.ssh/ansible ]; then
    ssh-keygen -b 3072 -t rsa -f /root/.ssh/ansible -q -N '' -C ansible
fi
regex="([[:alnum:]./:]+) \w+=([^ ]+) \w+=\"([^ ]*)\""
echo "" > /root/.ssh/config
python3 setup_ssh_config.py inventory > /root/.ssh/config

chown root /root/.ssh/config
exec $@