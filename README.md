# Subversion

A Puppet module for managing Subversion.

# Module usage

Module usage from Hiera is straightforward. To ensure that Subversion is 
installed:

    classes:
        - subversion

You can optionally setup Subversion repositories and/or backups using svndump:

    subversion::repos:
        repo_a:
            repodir: '/var/repos/repo_a'
        repo_b:
            repodir: '/var/repos/repo_b'
    subversion::backups:
        repo_a:
            repodir: '/var/repos/repo_a'
        repo_b:
            repodir: '/var/repos/repo_b'

See the following files for details:

* [Class: subversion](manifests/init.pp)
* [Define: subversion::repo](manifests/repo.pp)
* [Define: subversion::backup](manifests/backup.pp)

# Dependencies

See [metadata.json](metadata.json).

# Operating system support

This module has been tested on

* Debian 7
* Ubuntu 14.04

Any *NIX-style operating system should work out of the box or with small 
modifications.

For details see [params.pp](manifests/params.pp).
