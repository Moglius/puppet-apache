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
  $apache_conf_dir = lookup('apache::conf_dir')
  $port = lookup('apache::port')

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
    content => "<h1>Hello from ${facts['fqdn']}</h1>",
    alias   => 'index_file',
    notify  => Service['apache_service'],
  }

  # Creating a new vhost config file
  file { "${apache_conf_dir}${$vhost_name}.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template('apache/virtualhost.erb'),
    notify  => Service['apache_service'],
  }

  if $facts['osfamily'] == 'Debian' {
    exec { 'run a2ensite':
      command => "/usr/sbin/a2ensite ${$vhost_name}.conf",
      path    => '/usr/bin:/usr/sbin:/bin',
      cwd     => $apache_conf_dir,
      notify  => Service['apache_service'],
    }
  }

}
