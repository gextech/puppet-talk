$repo_server = 'http://10.177.62.100/~tomas'
$url_root     = "${repo_server}/repo/jdk/"
$package_name =  'jdk-7u45-linux-x64.gz'

Exec { path => ['/bin', '/sbin', '/usr/bin', 'usr/sbin'] }

file { '/usr/lib/jvm/':
  ensure => directory,
}
$jname = split($package_name,'[.]')
file { "/usr/lib/jvm/${jname[0]}":
  ensure  => directory,
  require => File['/usr/lib/jvm'],
}
$uri = "${url_root}${package_name}"
$dowloadCmd = "wget --user=${user} --password=${password} -q ${uri} -O /usr/lib/jvm/${package_name}"
exec { $dowloadCmd :
  command => $dowloadCmd,
  creates => "/usr/lib/jvm/${package_name}",
  notify  => Exec['unpack-java'],
  timeout => 30,
  require => File['/usr/lib/jvm'],
}
exec { 'unpack-java':
  command     => "tar zxf ${package_name} -C ${jname[0]} --strip-components=1;",
  cwd         => '/usr/lib/jvm/',
  path        => '/bin',
  refreshonly => true,
  notify      => Exec['update-alternatives'],
  require     => [File [ "/usr/lib/jvm/${jname[0]}"], Exec[$dowloadCmd]],
}
exec { 'update-alternatives':
  command     => "update-alternatives --install /usr/bin/java java /usr/lib/jvm/${jname[0]}/jre/bin/java 1;
                  update-alternatives --set java /usr/lib/jvm/${jname[0]}/jre/bin/java",
  cwd         => '/',
  path        => '/bin:/usr/sbin',
  refreshonly => true,
}
