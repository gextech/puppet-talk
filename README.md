puppet-talk
============

puppet-talk for gex

vagrant box add debian-wheezy http://169.254.187.171/~tomas/boxes/debian-wheezy-puppet.box 
vagrant destroy
vagrant up
puppet apply
java -version 
puppet apply --verbose --modulepath '/etc/puppet/modules:/puppet-src/modules'  /puppet-src/init.pp --detailed-exitcodes || [ $? -eq 2 ]

* Foreman is running at https://vagrant-debian-wheezy.vagrantup.com
Default credentials are 'admin:changeme'
* Foreman Proxy is running at https://vagrant-debian-wheezy.vagrantup.com:8443
* Puppetmaster is running at port 8140


vi /etc/puppet/puppet.conf

server = vagrant-debian-wheezy.vagrantup.com
report = true
pluginsync = true
certname = agent.example.local
puppet agent --test

on master
puppet cert list
puppet cert sign agent.example.local

vi /etc/hosts
10.177.62.203   puppet vagrant-debian-wheezy.vagrantup.com


10.177.62.146


