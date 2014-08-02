class base-utils::service {

service { "crond":
ensure => running,
enable => true,
hasrestart => true,
hasstatus => true,
}

}

