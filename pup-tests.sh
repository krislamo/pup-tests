#!/bin/bash

cat << "EOF"
 _____                        _     _______        _
|  __ \                      | |   |__   __|      | |
| |__) |   _ _ __  _ __   ___| |_     | | ___  ___| |_ ___
|  ___/ | | | '_ \| '_ \ / _ \ __|    | |/ _ \/ __| __/ __|
| |   | |_| | |_) | |_) |  __/ |_     | |  __/\__ \ |_\__ \
|_|    \__,_| .__/| .__/ \___|\__|    |_|\___||___/\__|___/
            | |   | |
            |_|   |_|       by Kris Lamoureux

Random Puppet tests and projects written for learning
https://github.com/krislamo/pup-tests

To the extent possible under law, Kris Lamoureux has waived
all copyright and related or neighboring rights to Puppet
Tests. This work is published from the United States.

You can copy, modify, distribute and perform the work, even
for commercial purposes, all without asking permission.

=============================================================

EOF

if [ "$1" == "create" ]
then

  mkdir -p keys

  if [ -f ./keys/backup-key ] || [ -f ./keys/backup-key.pub ] ; then
    rm ./keys/backup-key*
  fi

  ssh-keygen -t rsa -b 4096 -N '' -f ./keys/backup-key

  chmod -R 777 ./keys

  vagrant destroy -f
  vagrant up

  vagrant ssh master -c "sudo puppet cert sign webserver.localdomain"
  vagrant ssh master -c "sudo puppet cert sign backups.localdomain"

  vagrant ssh webserver -c "sudo puppet agent -t"
  vagrant ssh backups -c "sudo puppet agent -t"

elif [ "$1" == "apply" ]
then
  vagrant ssh master -c "cd /etc/puppet/code/environments/production && \
                         r10k puppetfile install"
  vagrant rsync
  if [ -z "$2" ]; then
    vagrant ssh webserver -c "sudo puppet agent -t"
    vagrant ssh backups -c "sudo puppet agent -t";
  else
    vagrant ssh $2 -c "sudo puppet agent -t";
  fi

elif [ "$1" == "cert-update" ]
then
  vagrant ssh master -c "sudo puppet cert clean $2.localdomain"
  vagrant ssh $2 -c "sudo find /var/lib/puppet/ssl -name $2.localdomain.pem -delete"
  vagrant ssh $2 -c "sudo puppet agent -t"
  sleep 3
  vagrant ssh master -c "sudo puppet cert sign $2.localdomain"
  sleep 3
  vagrant ssh $2 -c "sudo puppet agent -t"

elif [ "$1" == "help" ]
then
  cat << "EOF"
    Commands

    create        creates the environment from the ground up
    apply         syncs code and runs the puppet agent on specified client
    cert-update   update SSL cert
    help          displays this page
EOF

else
  printf "Error: Command \"$1\" unknown. See \"./pup-tests.sh help\"\n"
fi

