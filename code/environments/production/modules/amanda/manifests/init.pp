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

  # Backup config
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

}

