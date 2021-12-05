# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @example
#   apache::vhost { 'namevar': }
define apache::vhost (
  String  $vhost_name,
  String  $document_root,
) {

  # root Directory
  file { $document_root:
    ensure => directory,
    owner  => $apache::apache_user,
    group  => $apache::apache_user,
  }

  file { "${document_root}/index.html":
    ensure  => present,
    owner   => $apache::apache_user,
    group   => $apache::apache_user,
    content => "Hello from ${facts.fqdn}"
  }

}
