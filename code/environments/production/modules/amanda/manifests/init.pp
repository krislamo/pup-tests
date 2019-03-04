class amanda {

  # Install Amanda
  package { ['amanda-server','amanda-client','amanda-common']:
    ensure => present
  }

  # Enable "backup" user account
  user { 'backup':
    ensure => present,
    shell  => "/bin/bash"
  }

  # Create important Amanda directories
  file { ['/etc/amanda','/etc/amanda/MyConfig','/amanda',
          '/amanda/vtapes','/amanda/holding','/amanda/state']:
    ensure => directory,
    owner  => "backup"
  }

  # Create vtape directories
  file { ['/amanda/vtapes/slot1','/amanda/vtapes/slot2',
          '/amanda/vtapes/slot3','/amanda/vtapes/slot4']:
    ensure => directory,
    owner  => "backup"
  }

  # State directories
  file { ['/amanda/state/curinfo',
          '/amanda/state/log',
          '/amanda/state/index']:
    ensure => directory,
    owner  => "backup"
  }

  # Deploy config
  file { '/etc/amanda/MyConfig/amanda.conf':
    ensure  => file,
    content => template('amanda/amanda.conf.epp'),
    owner   => "backup"
  }

  # Backup locations
  file { '/etc/amanda/MyConfig/disklist':
    ensure  => file,
    content => template('amanda/disklist.epp'),
    owner   => "backup"
  }

#  # Enable remote access from backup server
#  file { '/var/backups/.ssh':
#    ensure => directory
#  }

  # Deploy temporary backup key made by pup-tests.sh
  file { '/home/vagrant/.ssh/id_rsa':
    ensure  => file,
    content => file('amanda/backup-key'),
    owner   => 'vagrant',
    mode    => "600"
  }

  # Deploy amanda hosts for the amanda server
  file { '/etc/amandahosts':
    ensure  => file,
    content => template('amanda/amandahosts-server.epp'),
    owner   => "backup"
  }

}

