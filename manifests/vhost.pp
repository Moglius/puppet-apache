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

  $apache_user = lookup('apache::apache_user')

  # root Directory
  file { $document_root:
    ensure => directory,
    owner  => $apache_user,
    group  => $apache_user,
    before => File['index_file'],
  }

  file { "${document_root}/index.html":
    ensure  => present,
    owner   => $apache_user,
    group   => $apache_user,
    content => "Hello from ${facts['fqdn']}",
    alias   => 'index_file'
  }

}
