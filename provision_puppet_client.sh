#!/bin/bash

sudo yum install -y http://fedora-mirror01.rbc.ru/pub/epel/6/i386/epel-release-6-8.noarch.rpm
sudo yum install -y https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

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

		bindaddress = 192.168.253.21

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


