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

Инициализация зашифрованного репозитория на backup-server

`borg init --encryption=repokey-blake2 /var/backups/client.bkp.local-etc`

На client прописать хост:

`echo '192.168.30.10 backup-server.bkp.local backup-server' >> /etc/hosts`

На client создать файл с passphrase

`vi /root/.borg-passphrase`

`chmod 400 /root/.borg-passphrase`

На client запустить скрипт

`sh /root/borgbackup_etc.sh`

PS авторизация по ssh ключу

4. Создание сервиса и таймера systemd

`vi /etc/systemd/system/backupscript.service`

```
[Unit]
Description=Borg Backup Script

[Service]
Type=oneshot
ExecStart=/bin/bash /root/borgbackup_etc.sh
```

`vi /etc/systemd/system/backupscript.timer`

```
[Unit]
Description=Borg Backup Timer

[Timer]
OnUnitActiveSec=300s
OnBootSec=10s

[Install]
WantedBy=timers.target
```

`systemctl daemon-reload`

`systemctl enable backupscript.timer`

`systemctl start backupscript.timer`

5. Проверка репозитория borg

`borg list /var/backups/client.bkp.local-etc/`

```
Enter passphrase for key /var/backups/client.bkp.local-etc:
2021-03-03-11-35                     Wed, 2021-03-03 11:36:10 [b176f3d1d98414b9ce428ecf69d61a5fa216159206087e7374994a28c85cbc42]
2021-03-03-12-11                     Wed, 2021-03-03 12:11:46 [df9a7adfd020f98576e266b9b9c4b759d6396583b68b5cdb801b8943c2afcbca]
2021-03-03-12-56                     Wed, 2021-03-03 12:56:26 [53fdd880e685ed94616e87445fd92a3f8f9f8c9366d64debcedc7fffda206d03]
2021-03-05-05-52                     Fri, 2021-03-05 05:52:44 [e25a6f78c594a8373db62cb01c78287f4b2b29680a7f71aca8006758d8ae3daa]
2021-03-05-05-54                     Fri, 2021-03-05 05:54:58 [38bf9f4a4034108a17f0b96cd9cc04c767fcdb14e499b7265a0837c786c66157]
2021-03-05-06-00                     Fri, 2021-03-05 06:00:16 [d212c31493f5a46c27b1a7bc4bc44138b7f29467f748f6a5e327c984607fa978]
2021-03-05-06-05                     Fri, 2021-03-05 06:05:16 [0460199e96cc05c4fc695a8b5f24d55bead136e902a9288661615a4a92919062]
2021-03-05-06-11                     Fri, 2021-03-05 06:11:16 [f62212d1f24509a35450dde2f8088235e4e9da49e7a2d58e3fb565d69ac3ec89]
2021-03-05-06-17                     Fri, 2021-03-05 06:17:16 [c4931c6ad249f07d540dd720ed3aba6ffdc8b5ddd3b178c9594285fa8abd654f]
2021-03-05-06-23                     Fri, 2021-03-05 06:23:16 [2707f82934d539212987bc3afc0660729840046b8c093862f4ec55dcdd1e7b1e]
2021-03-05-06-29                     Fri, 2021-03-05 06:29:16 [b6b6477099fbd1557f71b0ef64f5d348ba11a0d7c890c3bb2c428163e8a455c7]
2021-03-05-06-35                     Fri, 2021-03-05 06:35:16 [2d33d691cc85da5b9a9b3a5b0c2862fa6098576552e4e26a5ec3c3250a29969c]
2021-03-05-06-41                     Fri, 2021-03-05 06:41:16 [78676d0e54da1c56266a5fc6e65dc9931a3f25ecf1cb3bdc9302cde05064ec73]
2021-03-05-06-47                     Fri, 2021-03-05 06:47:16 [3af324157a530efcdca743cb799b35f54ce337714ad27d8014d10df27e4e5bb9]
2021-03-05-06-53                     Fri, 2021-03-05 06:53:16 [40043ed0d2fa06fc68dc31fb6c5cc3272d738952fde75309747a1db6391eaee4]
2021-03-05-06-59                     Fri, 2021-03-05 06:59:16 [aab507d3bfe75774b7915bd142eb8872d530209a1153034b4db6519448b2d4d5]
2021-03-05-07-05                     Fri, 2021-03-05 07:05:16 [d4de7fa2219453e105fda1eaf24b348872d1f63c7c7492a56f7f2da233825af6]
2021-03-05-07-11                     Fri, 2021-03-05 07:11:16 [28215eeb1595f52699a49a97d48f8531d321a3b974201ea5dfe9712b94c8a57b]
2021-03-05-07-17                     Fri, 2021-03-05 07:17:16 [363ae40fa5700d855b30d09ab057f03c7a1b32c5d2b6bbd9a3dfa424a9b5de72]
2021-03-05-07-23                     Fri, 2021-03-05 07:23:16 [8eb90ea82b9fc8e3ef97ccff40d5a8ef5f10a71f4578c07d9db368dd4446270e]
2021-03-05-07-29                     Fri, 2021-03-05 07:29:16 [34600deaf20d286fe0f250dbad04dae14cec8e3d2779d26b479d6f70fcc67090]
2021-03-05-07-35                     Fri, 2021-03-05 07:35:16 [362a40db7c807e435bc601b39a73fe370c845c6803186664c4b5794b8cc7a651]
2021-03-05-07-41                     Fri, 2021-03-05 07:41:16 [97f4a863f3d97622273d7005e6e72f99fbb953b1016a076e2cecadf3a49aa6c8]
```
