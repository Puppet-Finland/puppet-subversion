#
# == Define: subversion::repo
#
# Create a new subversion repository to an arbitrary location
#
define subversion::repo
(
    $repodir
)
{
    exec { "subversion-svnadmin-create-${repodir}":
        command => "svnadmin create ${repodir}",
        path => [ '/usr/bin', '/usr/local/bin' ],
        creates => "${repodir}",
        require => Class['subversion::install'],
    }
}
