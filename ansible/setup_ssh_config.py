#! /usr/bin/python3
import os,sys,re

inventory_file:str=sys.argv[1]

try:
    file=open(inventory_file)

    regex=re.compile(r'^([\w\.]+)\s.*ansible_user=(\w+)')

    Lines = file.readlines()
    output=""
    for line in Lines:
        result=regex.search(line)
        server=result.group(1) if result else ""
        if server and output.find(server)<0:
            output+=f"Host node-{server}\n"
            output+=f"\tHostName {server}\n"
            output+=f"\tUser {result.group(2)}\n"
    output+=("Host github\n"
            "\tHostName github.com\n"
            "\tUser git\n"
            "Host gitlab\n"
            "\tHostName gitlab.com\n"
            "\tUser git\n"
            "Host *\n"
            "\tIdentityFile ~/.ssh/ansible\n"
            "\tAddKeysToAgent yes\n")
    print(output)
    
except:
    print(f"can't open file: {inventory_file}")

