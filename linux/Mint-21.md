# Mint 21

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

### User & Group Passwords | ```/etc/shadow``` & ```/etc/gshadow```

User Password Structure: ```username:password_hash:last_changed:min_age:max_age:warn_period:inactive:expire_date:reserved```

Group Password Structure: ```groupname:password_hash:administrators:members```

Commands:
- Change Password: ```sudo passwd [username]```
- Disable Password Logins (!): ```sudo passwd -l [username]```
- Check for Empty Passwords: ```sudo awk -F: '($2 == "") {print}' /etc/shadow```

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

## Services
Commands:
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

