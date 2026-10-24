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

Vulnerabilites:
- All regular users must have a password hash.
- All system users should have ```*``` as their password hash.
- The root account should have a ```!``` as its password hash.
