user{"admin":
  ensure => present,
  uid => '507',
  gid => 'admin',
  shell => '/bin/zsh',
  home => '/home/dave',
  managehome => true,
}
