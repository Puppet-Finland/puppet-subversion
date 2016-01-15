#
# == Define: subversion::backup
#
# Dump Subversion repositories to a directory using "svnadmin dump" and compress 
# them using gzip. New dumps overwrite the old ones, the idea being that a 
# backup application (e.g. rsnapshot or bacula) fetches the latest local backups 
# at regular intervals and no local versioning is thus necessary.
#
# This define depends on the 'localbackups' class. Also, the 'subversion' class 
# has to be included or this define won't be found.
#
# == Parameters
#
# [*ensure*]
#   Status of the backup job. Either 'present' or 'absent'. Defaults to 
#   'present'.
# [*backup_name*]
#   Filename for the backup. Defaults to the name of the resource ($title).
# [*repodir*]
#   A path to the repository/repositories.
# [*output_dir*]
#   The directory where to output the files. Defaults to '/var/backups/local'.
# [*quiet*]
#   Suppress standard output. This makes sure the dump does not produce useless 
#   "Dumping revision <n>" emails. Valid values are true (default) and false.
# [*hour*]
#   Hour(s) when svnadmin dump gets run. Defaults to 01.
# [*minute*]
#   Minute(s) when svnadmin dump gets run. Defaults to 10.
# [*weekday*]
#   Weekday(s) when svnadmin dump gets run. Defaults to * (all weekdays).
# [*email*]
#   Email address where notifications are sent. Defaults to top-scope variable
#   $::servermonitor.
#
define subversion::backup
(
    $repodir,
    $ensure = 'present',
    $backup_name = $title,
    $output_dir = '/var/backups/local',
    $quiet = true,
    $hour = '01',
    $minute = '10',
    $weekday = '*',
    $email = $::servermonitor
)
{
    validate_bool($quiet)

    include ::subversion

    $opts = $quiet ? {
        true    => ' -q ',
        false   => ' ',
        default => undef,
    }

    cron { "subversion-backup-${repodir}-cron":
        ensure      => $ensure,
        command     => "svnadmin${opts}dump ${repodir}|gzip > ${output_dir}/subversion-${backup_name}.gz",
        user        => root,
        hour        => $hour,
        minute      => $minute,
        weekday     => $weekday,
        require     => Class['localbackups'],
        environment => [ 'PATH=/bin:/usr/bin:/usr/local/bin', "MAILTO=${email}" ],
    }
}
