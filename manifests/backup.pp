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
# [*repo_dir*]
#   A path to the repository/repositories.
# [*output_dir*]
#   The directory where to output the files. Defaults to '/var/backups/local'.
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
    $ensure = 'present',
    $backup_name = $title,
    $repo_dir,
    $output_dir = '/var/backups/local',
    $hour = '01',
    $minute = '10',
    $weekday = '*',
    $email = $::servermonitor
)
{

    include subversion

    cron { "subversion-backup-${repo_dir}-cron":
        ensure => $ensure,
        command => "svnadmin dump ${repo_dir}|gzip > ${output_dir}/subversion-${backup_name}.gz",
        user => root,
        hour => $hour,
        minute => $minute,
        weekday => $weekday,
        require => Class['localbackups'],
        environment => [ 'PATH=/bin:/usr/bin:/usr/local/bin', "MAILTO=${email}" ],
    }
}
