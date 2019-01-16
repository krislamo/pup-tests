class wordpress {

  # Install webserver
  class { 'apache':
    default_vhost => false,
    mpm_module => 'prefork'
  }

  # Enable PHP support
  class { 'apache::mod::php': }

  # Install database server
  class { '::mysql::server': }

  # Install PHP's MySQL module
  package { 'php-mysql':
    ensure => present,
    notify => Service['apache2']
  }

  # Create database
  mysql::db { 'wordpress':
    user     => 'wordpress_user',
    password => 'Password1',
    host     => 'localhost',
    grant    => ['ALL', 'GRANT']
  }
 
  file { '/var/www/wordpress/':
    ensure => directory
  }

  file { '/var/www/wordpress/public_html/wp-config.php':
    ensure => file,
    content => template('wordpress/wp-config.php.epp')
  }
 
  # Deploy WordPress code
  archive { '/tmp/wordpress-5.0.3.tar.gz':
    ensure          => present,
    extract         => true,
    extract_command => 'tar xfz %s --strip-components=1',
    extract_path    => '/var/www/wordpress/public_html',
    source          => 'https://wordpress.org/wordpress-5.0.3.tar.gz',
    checksum        => 'f9a4b482288b5be7a71e9f3dc9b5b0c1f881102b',
    checksum_type   => 'sha1',
    creates         => '/var/www/wordpress/public_html/index.php',
    cleanup         => true
  }
 
  apache::vhost { 'www.example.com':
    port    => 80,
    docroot => '/var/www/wordpress/public_html',
    notify => Service['apache2']
  }

}

