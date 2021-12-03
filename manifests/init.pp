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

  notify { 'Using apache module': }

  notify { "port number: ${port}": }

  notify { "package name: ${package_name}": }

}
