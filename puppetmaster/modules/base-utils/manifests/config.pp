class base-utils::config inherits base-utils::install{

#file { '/etc/sudoers':
#  ensure => present,
#  owner => 'root',
#  group => 'root',
#  mode	=> 0440,
#  require => Package["sudo"],
#}->
#	file_line { 'sudo_rule_for_adding_sudoers.d':
#	   path => '/etc/sudoers',
#	   line => '#includedir /etc/sudoers.d',
#	}

#file { '/etc/sudoers.d':
#	ensure => directory,
#	owner => 'root',
#	group => 'root',
#	mode => 0750,
#	}->

#group { 'sudo':
#	ensure => present,
#	gid => '20000',
#}

}
