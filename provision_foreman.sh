#!/bin/bash

sudo yum install -y http://fedora-mirror01.rbc.ru/pub/epel/6/i386/epel-release-6-8.noarch.rpm
sudo yum install -y https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm


#yum install centos-release-SCL
#yum install ruby193.x86_64

#yum install -y http://yum.theforeman.org/releases/latest/el6/x86_64/foreman-release.rpm
#yum -y install foreman-installer

sudo yum install puppet -y
#sudo yum install -y git

sudo /bin/echo '192.168.253.20 puppetm.local' | sudo tee -a /etc/hosts
sudo /bin/echo '192.168.253.21 puppet-client.local' | sudo tee -a /etc/hosts
sudo /bin/echo '192.168.253.22 foreman.local' | sudo tee -a /etc/hosts

cat > /etc/puppet/puppet.conf <<EOF

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

	bindaddress = 192.168.253.22
	environment = production

[agent]
    # The file in which puppetd stores a list of the classes
    # associated with the retrieved configuratiion.  Can be loaded in
    # the separate ``puppet`` executable using the ``--loadclasses``
    # option.
    # The default value is '\$confdir/classes.txt'.
    classfile = \$vardir/classes.txt

    # Where puppetd caches the local configuration.  An
    # extension indicating the cache format is added automatically.
    # The default value is '\$confdir/localconfig'.
    localconfig = \$vardir/localconfig
EOF

sudo puppet agent --server puppetm.local -t --environment production


### Последний рабочий вариант
#foreman-installer --noop -v \
#  --foreman-configure-scl-repo \
#  --enable-foreman-proxy=true \
#  --foreman-proxy-tftp=true \
#  --foreman-proxy-tftp-servername="192.168.253.22" \
#  --foreman-proxy-dhcp=true \
#  --foreman-proxy-dhcp-interface="eth1" \
#  --foreman-proxy-dhcp-gateway="10.0.2.2" \
#  --foreman-proxy-dhcp-range="192.168.253.100 192.168.253.150" \
#  --foreman-proxy-dhcp-nameservers="10.0.2.2" \
#  --foreman-proxy-dns=true \
#  --foreman-proxy-dns-interface="eth1" \
#  --foreman-proxy-dns-zone="local" \
#  --foreman-proxy-dns-reverse="253.168.192.in-addr.arpa" \
#  --foreman-proxy-dns-forwarders="10.0.2.2" \
#  --puppet-server-ca=false \
#  --puppet-server=false \
#  --foreman-proxy-puppetrun=false \
#  --foreman-proxy-puppetca=false \
#  --puppet-agent=false


