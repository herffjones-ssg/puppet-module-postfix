# == Class: postfix
#
# Manages postfix
#
class postfix (
  $ensure  = 'present',
  $package = 'postfix',
  $service = 'postfix',
) {

  case $ensure {
    'present': {
      $package_ensure = present
      $service_ensure = 'running'
      $service_enable = true
    }
    'absent': {
      $package_ensure = absent
      $service_ensure = 'stopped'
      $service_enable = false
    }
    default: {
      fail("ensure is ${ensure} and must be either 'present' or 'absent'.")
    }
  }

  package { 'postfix':
    ensure => $package_ensure,
    name   => $package,
  }

  service { 'postfix':
    ensure => $service_ensure,
    name   => $service,
    enable => $service_enable,
  }
}
