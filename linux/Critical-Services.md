# Critical Services
## SSH
### Client | ```/etc/ssh/ssh_config```
Settings
- ForwardAgent no
- ForwardX11 no
- PasswordAuthentication no
- StrictHostKeyChecking ask
- HashKnownHosts yes

More Settings (add these yourself)
- PubkeyAuthentication yes

### Server | ```/etc/ssh/sshd_config```
Settings
- Port 22
- LogLevel INFO
- LoginGraceTime 30
- PermitRootLogin no
- StrictModes yes
- MaxAuthTries 3
- PubkeyAuthentication yes
- HostbasedAuthentication no
- IgnoreRhosts yes
- PasswordAuthentication no
- PermitEmptyPasswords no
- KbdInteractiveAuthentication no
- AllowAgentForwarding no
- AllowTcpForwarding no
- X11Forwarding no
- PermitUserEnvironment no
- ClientAliveInterval 300
- ClientAliveCountMax 2

More Settings (add these yourself)
- AllowUsers [username], [username]

## FTP
### Configuration File | ```/etc/vsftpd.conf```
Settings
- listen=YES
- listen_ipv6=NO
- anonymous_enable=NO
- local_enable=YES
- write_enable=NO
- local_umask=027
- xferlog_enable=YES
- xferlog_std_format=YES
- chroot_local_user=YES
- chroot_list_enable=YES
- chroot_list_file=/etc/vsftpd.chroot_list
- pam_service_name=vsftpd
- ssl_enable=YES

More Settings (add these yourself)
- allow_writeable_chroot=NO
- userlist_enable=YES
- userlist_deny=NO
  - allow only listed users in ```/etc/vsftpd.userlist```
- force_local_logins_ssl=YES
- force_local_data_ssl=YES
- userlist_file=/etc/vsftpd.user_list
- allow_anon_ssl=NO
- ssl_tlsv1=YES
- ssl_sslv2=NO
- ssl_sslv3=NO
- pasv_promiscuous=NO
- ssl_ciphers=HIGH
- anon_umask=027

### Disallowed FTP Users | ```/etc/ftpusers```
Default:
- root
- daemon
- bin
- sys
- sync 
- games
- man
- lp
- mail
- news
- uucp
- nobody

Ensure that the root user is in this file.

## SMB | ```/etc/samba/smb.conf```
Settings | ```[global]```
- server min protocol = SMB2_10
- client min protocol = SMB2_10
- smb encrypt = required
- server smb encrypt = required
- map to guest = Never
- usershare allow guests = no
- restrict anonymous = 2
- ntlm auth = ntlmv2-only
- disable spoolss = yes
- load printers = no

Commands
- Print Configurations/Errors: ```testparm```
