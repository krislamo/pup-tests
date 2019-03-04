class amanda::client {

  # Install Amanda
  package { ['amanda-client', 'amanda-common']:
    ensure => present
  }

  # Enable "backup" user account
  user { 'backup':
    ensure => present,
    shell => "/bin/bash"
  }

  # Enable remote access from backup server
  file { '/var/backups/.ssh':
    ensure => directory
  }

  # Deploy temporary backup key made by pup-tests.sh
  file { '/var/backups/.ssh/authorized_keys':
    ensure  => file,
    content => file('amanda/backup-key.pub'),
    owner   => 'backup',
    mode    => "644"
  }

  # Deploy amanda hosts for clients
  file { '/etc/amandahosts':
    ensure  => file,
    content => template('amanda/amandahosts-client.epp'),
    owner   => "backup"
  }

}

