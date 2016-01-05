#
# == Class subversion::install
#
# Install subversion
#
class subversion::install inherits subversion::params
{
    package { 'subversion-subversion':
        ensure => installed,
        name   =>  $::subversion::params::package_name,
    }
}
