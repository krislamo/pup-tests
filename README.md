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
* Vagrant 2.2.3
* Ansible 2.7.7
* Puppet 4.8.2

After installing the above, simply navigate to the root directory and deploy
the virtual machines:

`sudo chmod +x pup-tests.sh`

`./pup-tests.sh create`

The command above will create three virtual machines: a puppet master,
a wordpress websever, and an amanda backup server.

Apply any code changes with the command below (omit the machine to run
puppet on all clients):

`./pup-tests.sh apply [machine]`

And if for some reason you come across an invalid certificate while running
puppet, you can reapply a new certificate:

`./pup-tests.sh cert-update [machine]`
