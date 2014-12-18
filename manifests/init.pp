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

    create_resources('subversion::repo', $repos)
    create_resources('subversion::backup', $backups)

    include subversion::install
}
