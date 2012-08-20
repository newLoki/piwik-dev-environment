Exec {
  path => [
    "/bin",
    "/sbin",
    "/usr/bin",
    "/usr/sbin",
    "/usr/local/bin",
    "/usr/local/sbin"
  ],
}

class { 'piwik':
  directory     => '/var/www/piwik',
  repository    => 'svn',
  version       => 'trunk',
  db_user       => 'piwik@%',
  db_password   => 'secure',
  log_analytics => true,
}

piwik::apache { 'apache.piwik':
  port     => 80,
  docroot  => '/var/www/piwik',
  priority => '10',
  require  => Class['piwik'],
}

piwik::nginx { 'nginx.piwik':
  port    => 8080,
  docroot => '/var/www/piwik',
  require => Class['piwik'],
}
