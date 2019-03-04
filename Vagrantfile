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
    master.vm.synced_folder "./code", "/etc/puppet/code", type: "rsync",
      rsync__args: ["--verbose", "--archive", "-z", "--copy-links"]

    # Sync custom SSH keys to Puppet Master
    modpath = "/etc/puppet/code/environments/production/modules/"

    master.vm.provision "file",
      source: "./keys/backup-key",
      destination: modpath + "amanda/files/backup-key"

    master.vm.provision "file",
      source: "./keys/backup-key.pub",
      destination: modpath + "amanda/files/backup-key.pub"

  end

  # Clients / Agents
  servers = ["webserver", "backups"]
  ip = 101

  servers.each do |server|
    config.vm.define "#{server}" do |node|
      node.vm.box = "debian/stretch64"
      node.vm.hostname = "#{server}"
      node.vm.network 'private_network', ip: '192.168.121.' + ip.to_s
      ip = ip + 1

      node.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "setup/client.yml"
      end

    end

  end

end

