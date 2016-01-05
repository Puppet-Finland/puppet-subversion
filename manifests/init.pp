#
# == Class: subversion
#
# Class for installing and configuring Subversion and for creating subversion 
# repositories.
#
#
# == Parameters
#
# [*repos*]
#   A hash of subversion::repo defined resources.
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class subversion
(
    $repos = {},
    $backups = {}

) inherits subversion::params {

    validate_hash($repos)
    validate_hash($backups)

    create_resources('subversion::repo', $repos)
    create_resources('subversion::backup', $backups)

    include ::subversion::install
}
