# @summary Install & config Apache
#
# A description of what this class does
#
# @example
#   include apache
class apache (
  String  $package_name,
  String  $conf_file,
  String  $template_file,
  Integer $port,
){

  package { $package_name:
    ensure => installed,
    alias  => 'package',
  }

  $config_content = epp("apache/${template_file}", { port => $port })

  file { $conf_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $config_content,
    notify  => Service['apache_service'],
  }

  service { $package_name:
    ensure    => running,
    subscribe => Package['package'],
    alias     => 'apache_service',
  }

}
