# @summary Install & config Apache
#
# A description of what this class does
#
# @example
#   include apache
class apache (
  String  $package_name,
  Integer $port,
){

  package { $package_name:
    ensure => installed,
    alias  => 'package',
  }

  service { $package_name:
    ensure    => running,
    subscribe => Package['package'],
  }

}
