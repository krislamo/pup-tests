# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Disable default syncing of the project directory
  config.vm.synced_folder ".", "/vagrant", disabled: true
 
  # Puppet Master
  config.vm.define "master" do |master|
    master.vm.box = "debian/stretch64"
    master.vm.hostname = "puppetmaster"
    master.vm.network 'private_network', ip: '192.168.121.100'

    # Setup Puppet Master via Ansible
    master.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "setup/master.yml"
    end

    # Sync Puppet code to Puppet Master
    master.vm.synced_folder "./code", "/etc/puppet/code"

  end

  # Puppet Agent
  config.vm.define "webserv" do |webserv|
    webserv.vm.box = "debian/stretch64"
    webserv.vm.hostname = "webserver"
    webserv.vm.network 'private_network', ip: '192.168.121.101'

    # Setup Puppet Agent via Ansible
    webserv.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "setup/client.yml"
    end

  end

end

