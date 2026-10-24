// replace files with the ones in secured
replace /etc/default/grub with /linux/files/secure/\etc\default\grub
replace /etc/login.defs with /linux/files/secure/\etc\login.defs
replace /etc/pam.d/common-auth with /linux/files/secure/\etc\pam.d\common-auth
replace /etc/pam.d/common-password with /linux/files/secure/\etc\pam.d\common-password
replace /etc/security/pwquality.conf with /linux/files/secure/\etc\security\pwquality.conf
replace /etc/sudo.conf with /linux/files/secure/\etc\sudo.conf
replace /etc/sysctl.conf with /linux/files/secure/\etc\sysctl.conf

// firewall part
sudo ufw enable
sudo ufw default de
sudo ufw default allow outgoing
sudo ufw logging high

// unhold everything
sudo apt-mark unhold $(apt-mark showhold)

// auditing
sudo apt install auditd
sudo systemctl enable rsyslog
systemctl enable systemd-journald

// apply changes part
sudo update-grub
sudo sysctl -p

// pam modules
if debsums -s libpam-modules = output {
  sudo apt install --reinstall libpam-modules
  debsums -s libpam-modules = output {
    alert me
  }
}

// permission stuff
chmod 644 /etc/passwd
chmod 644 /etc/group
chmod 640 /etc/shadow
chmod 640 /etc/gshadow
chmod 440 /etc/sudoers
chmod 440 /etc/sudoers.d/*
chmod 644 /etc/crontab
chmod 644 /etc/login.defs
chmod 644 /etc/hosts
chmod 644 /etc/apt/sources.list
chmod 644 /etc/sysctl.conf
chmod 755 /home/
chmod 755 /etc
