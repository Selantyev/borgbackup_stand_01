# borgbackup_stand_01

1. Развёрнуты две виртуалки - client и backup-server
2. Установка borgbackup на хостах client и backup-server

Установка borgbackup:

`yum update -y`

`yum install epel-release`

`yum install borgbackup`

`borg -V`

`borg 1.1.15`

Создание пользователя:

`useradd borg`

`passwd borg`

Подготовка диска на backup-server:

`fdisk /dev/sdb`

`mkfs.xfs -f /dev/sdb`

`mkdir /var/backups`

`mount /dev/sdb /var/backups`

`echo '/dev/sdb /var/backups xfs defaults 0 0' >> /etc/fstab`

3. Настройка borgbackup

На client прописать хост:

`echo '192.168.30.10 backup-server.bkp.local backup-server' >> /etc/hosts`

Инициализация зашифрованного репозитория на backup-server

`borg init --encryption=repokey-blake2 /var/backups/client.bkp.local-etc`
