#
# == Class subversion::install
#
# Install subversion
#
class subversion::install inherits subversion::params
{
    package { 'subversion-subversion':
        name =>  "${::subversion::params::package_name}",
        ensure => installed,
    }
}
