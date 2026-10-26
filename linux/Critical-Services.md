# Critical Services
## SSH
### Client | ```/etc/ssh/ssh_config```
Settings
- PasswordAuthentication no
- PublicKeyAuthentication yes
- AllowUsers [user1], [user2]
- ForwardAgent no

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
- AllowUsers [username] [username]
  - This setting isn't in the file by default.
