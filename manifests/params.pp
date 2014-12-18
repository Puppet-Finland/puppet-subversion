#
# == Class: subversion::params
#
# Defines some variables based on the operating system
#
class subversion::params {

    case $::osfamily {
        'RedHat': {
            $package_name = 'subversion'
        }
        'Debian': {
            $package_name = 'subversion'
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
