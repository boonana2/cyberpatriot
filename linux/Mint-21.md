# Mint 21
## User Auditing
### Users & Groups | ```/etc/passwd``` & ```/etc/groups```
Users Structure: ```username:password:UID:GID:comment:home_directory:shell```
Groups Structure: ```group:password:GID:users```

User Commands:
- Create Account: ```sudo adduser [username]```
- Delete Account: ```sudo deluser [username]```
- Enable Account: ```sudo usermod -L [username]```
- Disable Account: ```sudo usermod -U [username]```
- Change Password: ```sudo passwd [username]```

Group Commands:
- Create Group: ```sudo groupadd [groupname]```
- Delete Group: ```sudo groupdel [groupname]```
- Add User to Group: ```sudo usermod -aG [groupname] [username]```
- Remove User from Group: ```sudo gpasswd -d [username] [groupname]```
- Change Group Password: ```sudo gpasswd [groupname]```
### User & Group Passwords | ```/etc/shadow``` & ```/etc/gshadow```
