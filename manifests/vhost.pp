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
    alias  => 'document_root_folder',
  }

  file { "${document_root}/index.html":
    ensure  => present,
    owner   => $apache_user,
    group   => $apache_user,
    content => "Hello from ${facts['fqdn']}",
    require => File['document_root_folder'],
  }

}
