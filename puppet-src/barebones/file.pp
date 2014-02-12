file { 'test_file':
 path    => '/tmp/hola.txt',
 content => 'Hola mundo ',
 mode    => 0640,
 ensure  => present
}
