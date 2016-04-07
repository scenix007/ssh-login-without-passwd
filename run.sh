#!/usr/bin/env bash

#input username and hostname
read -p 'Input your username and hostname, like"aaron@192.168.1.1"
:' username_and_host
echo "Your username and host is $username_and_host"

#check if rsa file 
if [ -f ~/.ssh/id_rsa.pub ]
then
    echo 'RSA file already generated'
else 
    echo 'RSA file not found, start generating...'
    ssh-keygen -t rsa
fi

echo 'Making remote .ssh dir, enter password below'
ssh $username_and_host mkdir -p .ssh

echo 'Coping rsa file to remote, enter password below'
cat ~/.ssh/id_rsa.pub | ssh $username_and_host \
    'cat >> .ssh/authorized_keys ; chmod 700 .ssh ; chmod 640 .ssh/authorized_keys'

echo 'ALL DONE'
