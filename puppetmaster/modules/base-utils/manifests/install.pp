class base-utils::install {

  Package {
    ensure => present,
  }

#  package { "screen":
#  }
#  
#  package { "man":
#  }
  
#  @package { "bind-utils":
#  }
#  
#  Package <| name == bind-utils |>

#  package { "telnet":
#  }
  
  package { "mc":
  }  
  
#  package { "tree":
#  }
  
  package { "lsof":
  }
  
#  package { "openssl":
#  ensure => latest,
#  }
 
  package { "sudo":
  ensure => latest,
  }
 
  package { "yum-utils":
  }
    
#  package { "sysstat":
#  }

  package { "fcoe-utils":
    ensure => absent,
  }    
  
		case $::operatingsystem { 
		'CentOS': { 
		        case $::operatingsystemmajrelease { 
		                '6': { 
#		                      	     package { "ncdu":}
#		                      	     package { "policycoreutils-python":}
#		                      	     package { "cifs-utils":}
#		                      	     package { "yum-plugin-changelog":}
		                      	     
		                      } 
		        }
		} 
	}
  
  

}

