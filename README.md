# Puppet Tests
Puppet Tests (or pup-tests) is a small project where I am learning Puppet by
writing it. Some of this code was written while performing my duties as an
employee of the University of Georgia.

This project is in the public domain within the United States, and copyright
and related rights in the work worldwide are waived through the
[CC0 1.0 Universal Public Domain Dedication](
https://creativecommons.org/publicdomain/zero/1.0/). All contributions to this
project will be released under the CC0 dedication. By submitting a pull
request, you are agreeing to comply with this waiver of copyright interest.

## Getting Started
Puppet Tests is developed using the following technologies:
* Vagrant 2.2.2 + vagrant-libvirt 0.0.45
* Ansible 2.7.5
* Puppet 4.8.2

After installing the above, simply navigate to the root directory and deploy
the virtual machines:

`vagrant up`

Vagrant will create at least two virtual machines and provision a puppet
client-server architecture using Ansible code from the /setup/ folder. You will
want to login to client:

`vagrant ssh webserv`

After logging into the puppet client, provision the machine:

`sudo puppet agent -t`

