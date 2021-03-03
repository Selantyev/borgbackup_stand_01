# borgbackup_stand_01

1. Развёрнуты две виртуалки - client и backup-server
2. Установка borgbackup на хост backup-server

`yum update -y`

`yum install epel-release`

`yum install borgbackup`

`borg -V`
`borg 1.1.15`

`useradd borg`

`passwd borg`
