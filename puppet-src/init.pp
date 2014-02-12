Exec {
  path => [
    '/usr/local/bin',
    '/opt/local/bin',
    '/usr/bin', 
    '/usr/sbin', 
    '/bin',
    '/sbin'],
    logoutput => true,
}
exec {'echo 10.177.62.203 puppet vagrant-debian-wheezy.vagrantup.com >> /etc/hosts':}


file{"/etc/puppet/puppet.conf":
  path    => '/etc/puppet/puppet.conf',
  content => "[main]
  server = vagrant-debian-wheezy.vagrantup.com
  report = true
  pluginsync = true
  certname = agent.vagrant.$domain
  logdir=/var/log/puppet
  vardir=/var/lib/puppet
  ssldir=/var/lib/puppet/ssl
  rundir=/var/run/puppet
  factpath=\$vardir/lib/facter
  templatedir=\$confdir/templates

  [master]
  # These are needed when the puppetmaster is run by passenger
  # and can safely be removed if webrick is used.
  ssl_client_header = SSL_CLIENT_S_DN
  ssl_client_verify_header = SSL_CLIENT_VERIFY",
  mode    => 0775,
  ensure  => present
}
cron { puppetagent:
 command => "puppet agent --test ",
 user    => root,
 hour    => "*",
 minute  => "*/5",
 require => File["/etc/puppet/puppet.conf"]
}
