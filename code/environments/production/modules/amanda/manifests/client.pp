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

  # Deploy amanda hosts for clients
  file { '/etc/amandahosts':
    ensure  => file,
    content => template('amanda/amandahosts-client.epp'),
    owner   => "backup"
  }

}

