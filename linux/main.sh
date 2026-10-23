// replace essential files part
all files in secure
sudo sysctl -p

// firewall part
sudo ufw enable
sudo ufw default de
sudo ufw default allow outgoing
sudo ufw logging high

// unhold everything
sudo apt-mark unhold $(apt-mark showhold)



// apply changes part
sudo update-grub


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
