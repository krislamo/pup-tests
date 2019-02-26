node 'webserver' {
  include wordpress
  include amanda::client
}

node 'backups' {
  include amanda
}

