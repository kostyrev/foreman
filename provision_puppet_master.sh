#!/bin/bash

sudo yum install -y http://fedora-mirror01.rbc.ru/pub/epel/6/i386/epel-release-6-8.noarch.rpm
sudo yum install -y https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

#yum install -y http://yum.theforeman.org/releases/latest/el6/x86_64/foreman-release.rpm
#yum -y install foreman-installer


sudo /bin/echo '192.168.253.20 puppetm.local' | sudo tee -a /etc/hosts
sudo /bin/echo '192.168.253.21 puppet-client.local' | sudo tee -a /etc/hosts
sudo /bin/echo '192.168.253.22 foreman.local' | sudo tee -a /etc/hosts



sudo yum install puppet-server -y
sudo yum install -y git 


sudo touch /etc/puppet/autosign.conf
sudo /bin/echo '*.local' | sudo tee -a /etc/puppet/autosign.conf

sudo cat > /etc/puppet/puppet.conf <<EOF


[main]
    # The Puppet log directory.
    # The default value is '\$vardir/log'.
    logdir = /var/log/puppet

    # Where Puppet PID files are kept.
    # The default value is '\$vardir/run'.
    rundir = /var/run/puppet

    # Where SSL certificates are kept.
    # The default value is '\$confdir/ssl'.
    ssldir = \$vardir/ssl

    # Allow puppet group read access to private SSL files
    # For sharing cerfificates with The Foreman for instance
    privatekeydir = \$ssldir/private_keys { group = service }
    hostprivkey = \$privatekeydir/\$certname.pem { mode = 640 }

    # To enable custom facts
    pluginsync = true
    basemodulepath = \$confdir/modules:/usr/share/puppet/modules
    environmentpath = \$confdir/environments
    ignorecache = true

		bindaddress = 192.168.253.20

[agent]
    # Puppet master host
    server = puppetm.local


    # Extra options
    environment = production

[master]
    autoflush = true
    masterlog = /var/log/puppet/puppetmaster.log
EOF

sudo /etc/init.d/puppetmaster start
sudo puppet agent --server puppetm.local -t --environment production

### Последний рабочий вариант
#foreman-installer --noop -v \
#  --enable-foreman-proxy \
#  --foreman-configure-scl-repo \
#  --foreman-proxy-tftp=false \
#  --foreman-proxy-dhcp=false \
#  --foreman-proxy-dns=false \
#  --puppet-server-ca=false \
#  --puppet-server=false \
#  --foreman-proxy-puppetrun=false \
#  --foreman-proxy-puppetca=true \
#  --foreman-proxy-register-in-foreman=true \
#  --foreman-proxy-ssl=true \
#  --foreman-proxy-ssl-ca=true \
#  --puppet-agent=false


