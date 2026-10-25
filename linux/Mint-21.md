# Mint 21

## Forensics
Display Directory's Contents: ```tree```

Display Directory's Contents Detailed: ```tree -a```



## User Auditing

### Users & Groups | ```/etc/passwd``` & ```/etc/groups```

User Structure: ```username:password:UID:GID:comment:home_directory:shell```

Group Structure: ```group:password:GID:users```

User Commands:
- Create Account: ```sudo adduser [username]```
- Delete Account: ```sudo deluser [username]```
- Enable Account: ```sudo usermod -L [username]```
- Disable Account: ```sudo usermod -U [username]```

Group Commands:
- Create Group: ```sudo groupadd [groupname]```
- Delete Group: ```sudo groupdel [groupname]```
- Add User to Group: ```sudo usermod -aG [groupname] [username]```
- Remove User from Group: ```sudo gpasswd -d [username] [groupname]```
- Change Group Password: ```sudo gpasswd [groupname]```
- Print Group Members: ```getent group [groupname]```

Vulnerabilities:
- The root account should be the only account with a UID and GID of 0.
- All service users should not have a login shell.
- All normal users should have a login shell.
- All normal users should have a UID over 1000.
- No users should have a duplicate UID / GID.
- All users should have a home directory in ```/home```.

### User & Group Passwords | ```/etc/shadow``` & ```/etc/gshadow```

User Password Structure: ```username:password_hash:last_changed:min_age:max_age:warn_period:inactive:expire_date:reserved```

Group Password Structure: ```groupname:password_hash:administrators:members```

Commands:
- Change Password: ```sudo passwd [username]```
- Disable Password Logins (!): ```sudo passwd -l [username]```
- Check for Empty Passwords: ```sudo awk -F: '($2 == "") {print}' /etc/shadow```
- Change Password at Next Login: ```sudo passwd -e [username]```

Vulnerabilites:
- All regular users must have a password hash.
- All system users should have ```*``` as their password hash.
- The root account should have a ```!``` as its password hash.

## Sudoers
Key Files
- Sudoers File: ```/etc/sudoers```
- Edit Sudoers File: ```sudo visudo```
- Sudoers Directory: ```/etc/sudoers.d```
- Sudoers Configuration: ```/etc/sudo.conf```

## Policies
### PAM
Key Files
- Common Password: ```/etc/pam.d/common-password```
- Password Quality: ```/etc/security/pwquality.conf```
- Common Authorization: ```/etc/pam.d/common-auth```

PAM Modules
- Check Tampering: ```debsums -s libpam-modules```
- If there's an output, it has been tampered with.
- Remediation: ```sudo apt install --reinstall libpam-modules```
### Other
Key Files
- Login Definitions: ```/etc/login.defs```
- Boot Parameters: ```/etc/default/grub```
- System Control: ```/etc/sysctl.conf```

## Services
Commands:
- List All Services: ```service --status-all```
- Enable Service: ```sudo systemctl enable [service]```
- Disable Service: ```sudo systemctl disable [service]```
- Start Service: ```sudo systemctl start [service]```
- Stop Service: ```sudo systemctl stop [service]```
- Check Service Status: ```systemctl status [service]```

## Applications
Commands:
- Install Package: ```sudo apt install [package]```
- Remove Package: ```sudo apt purge [package]```
- Remove Unused Dependencies: ```sudo apt autoremove --purge```
- Clear Old Cache: ```sudo apt autoclean```
- Show Held Packages: ```apt-mark showhold```
- Unhold Packages: ```sudo apt-mark unhold [package]```
- Unhold All: ```sudo apt-mark unhold$(apt-mark showhold)```

## Updates
Commands:
- apt Directory: ```/etc/apt/apt.conf.d```
- Update: ```sudo apt update && sudo apt upgrade && sudo apt dist-upgrade -y```

Vulnerabilities:
- Enable Automatic Updates in GUI.

Additional Info:
- Compare the apt directory with the baseline.

## Web Browsers
update these and secure em

## Permissions
### Permissions | ```chmod```
Structure: ```chmod [permission] [file]```

This command changes the executing, reading, and writing permissions for a file.

Example: ```chmod 644 /etc/passwd```

There shouldn't be any world-writable files on the system.
Find World-Writable Files in Certain Directories: ```find /bin /sbin /usr/bin /usr/sbin /etc -type f -perm -o+w 2>/dev/null```

Most of the time, the command above should return nothing.

Fix World-Writable Files: ```sudo chmod o-w [file]```

### Ownership | ```chown```
Structure: ```chown [username]:[groupname] [file]```

This command changes the user and group ownership of a file.

Example: ```chown root:root /etc/passwd```

### Default Permissions | ```umask```
Structure: ```umask [permission]```

This command changes the default permissions for newly created files and directories.

Example: ```umask 027```

To implement this, ```umask 027``` must be added to the bottom of ```/etc/profile``` and ```/etc/bash.brc```.

### SUID / GUID
Allows files to run with the permissions of the file's owner or group.

Commands:
- Find SUID: ```find / -perm /4000 2>/dev/null```
- Find SGID: ```find / -perm /2000 2>/dev/null```
- Delete SUID: ```sudo chmod u-s [file]```
- Delete SGID: ```sudo chmod g-s [file]```

Compare these with the baseline.

### File Capabilities
Structure: ```setcap [capability]+eip [file]```

Commands:
- Set Capability: ```setcap [capability]+eip [file]```
- Remove All Capabilities: ```sudo setcap -r [file]```
- View Capabilities: ```getcap [file]```

Capabilities:
- cap_setuid | ability to change what user you are running as
- cap_setgid | ability to change what group you are running as
- cap_sys_admin | admin permissions
- cap_dac_override | bypass permissions
- cap_dac_read_search | bypass permissions
- cap_chown | ability to change ownership
- cap_fowner | ability to change ownership
- cap_kill | ability to kill any program
- cap_sys_ptrace | ability to debug and tamper with any program

Required Capabilities
- gnome-keyring-daemon = cap_ipc_lock+ep
- mtr-packet = cap_net_raw+ep
- ping = cap_net_raw+ep
- traceroute6.iputils = cap_net_raw+ep

### Extended File Attributes and ACLs
i do later

## Firewall
Commands:
- Firewall Status: ```sudo ufw status verbose```
- Enable Firewall: ```sudo ufw enable```
- Deny Incoming: ```sudo ufw default deny incoming```
- Allow Outgoing: ```sudo ufw default allow outgoing```
- Enable Logging: ```sudo ufw logging high```
- Allow Port: ```sudo ufw allow [port]```
- Deny Port: ```sudo ufw deny [port]```

Ports:
- <1024 = System Services
- 1024 - 49151 = Applications
- 49152 - 65535 = Temporary Connections (dyanimic/ephemeral)

Important Ports:
- SSH: 22
- HTTP: 80
- HTTPS: 443
- FTP: 21
- SMTP: 25
- DNS: 53
- MySQL - 3306
- RDP - 3389
- HTTP - 8080

## Auditing
Comamands:
- Install: ```sudo apt install auditd```
- Check Status: ```systemctl status auditd```
- Enable: ```sudo systemctl enable rsyslog```
- Enable: ```sudo systemctl enable systemd-journald```

## Prohibited Files
Structure: ```find [path] [options] [action]```

Example: ```sudo find / -name ".*.mp3"```

The ```.``` before the ```*``` in ```sudo find / -name ".*.mp3"``` is to ensure that it also searches for hidden files.
Hidden files have a ```.``` in their names.

Example: ```.hiddenfile.txt```

### Media
Audios & Videos
- .mp3 | .mp4 | .mov | .ogg | .mkv | .avi | .wav | .flac | .webm | .jpg | .jpeg | .png | .gif

Scripts
- .py | .sh | .pl | .rb | .php | .bin | .run | .AppImage | .elf | .ps1 | .bat

Archives
- .zip | .gz | .tar | .7z | .rar | .bz2 | .xz | .tar.gz | .tgz | .iso

Install
- .deb | .rpm | .snap | .flatpak | .flatpakref

Other
- .txt

### Malicious Malware
Places to Look:
- /etc/init.d
- /etc/rc* (rc.local, rc0.d, rc1.d, etc)
- /etc/bash.bashrc
- .bashrc file

### Protected Files
If a file is protected, try the following:
- Taking Ownership: ```sudo chown [user]:[user] [file]```
- Changing Permissions: ```sudo chmod [permission] [file]```
- Changing Attributes: ```sudo chattr [options] [file]```

```chattr``` Example: ```sudo chattr -i /etc/passwd```

## Scheduled Tasks
Commands
- System-Wide Jobs: ```/etc/crontab```
- Periodical Jobs: ```/etc/crontab.*```
- User Jobs: ```/var/spool/cron/crontabs```
