node 'webserver' {
  include wordpress
}

node 'backups' {
  include amanda
}

