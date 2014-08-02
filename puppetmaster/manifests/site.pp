#import "classes/*.pp"

Package {
	allow_virtual => false,
}

node default {

  include base-utils

}

node 'puppetm.local' inherits default {

    class {"foreman_proxy":
        puppetca              => true,
        tftp                        => false,
        dhcp                      => false,
        dhcp_managed    => false,
        dns                        => false,
        dns_managed      => false,
    }
    

}




# Подключайте новые модулю к этой ноде
node 'puppet-client.local' inherits default {




}


# Подключайте новые модулю к этой ноде
node 'foreman.local' inherits default {

    include foreman

    class {"foreman_proxy":
        puppetca   => false,
        manage_sudoersd => false,
        puppetrun              => false,
        tftp                          => true,
        tftp_servername   => $ipaddress_eth1,
        dhcp                         => true,
        dhcp_managed       => true,
        dhcp_interface       => 'eth1',
        dhcp_gateway         => $ipaddress_eth1,
        dhcp_range              => "192.168.253.100 192.168.253.150" ,
    #    dhcp_nameservers => ['10.0.2.2',],
        dns                        => true,
        dns_managed      => true,
        dns_interface      => 'eth1',
        dns_zone             => 'local',
        dns_reverse        => '253.168.192.in-addr.arpa',
        dns_forwarders   => ['10.0.2.2',],
    }

}
