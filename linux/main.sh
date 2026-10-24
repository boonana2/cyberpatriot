#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Error: No Sudo Permissions"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SECURE_DIR="$SCRIPT_DIR/files/secure"

REAL_USER="${SUDO_USER:-root}"
USER_HOME="$(getent passwd "$REAL_USER" | cut -d: -f6)"
BACKUP_DIR="$USER_HOME/Desktop/backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

FAILURES=()

run() {
  "$@" >/dev/null 2>&1 || FAILURES+=("FAILED: $*")
}

# -------------------- Replace Files with Secured Ones --------------------
FILES=(
  /etc/default/grub
  /etc/login.defs
  /etc/pam.d/common-auth
  /etc/pam.d/common-password
  /etc/security/pwquality.conf
  /etc/sudo.conf
  /etc/sysctl.conf
)

for dest in "${FILES[@]}"; do
  src="$SECURE_DIR/${dest//\//\\}"

  if [ ! -f "$src" ]; then
    FAILURES+=("MISSING secure file: $src")
    continue
  fi

  if [ -f "$dest" ]; then
    mkdir -p "$BACKUP_DIR$(dirname "$dest")"
    cp -p "$dest" "$BACKUP_DIR$dest" || FAILURES+=("BACKUP FAILED: $dest")
  fi

  cp "$src" "$dest" || FAILURES+=("REPLACE FAILED: $dest")
done

# -------------------- Firewall --------------------
run ufw --force enable
run ufw default deny incoming
run ufw default allow outgoing
run ufw logging high

# -------------------- Unhold Everything --------------------
HELD="$(apt-mark showhold)"
if [ -n "$HELD" ]; then
  run apt-mark unhold $HELD
fi

# -------------------- Auditing --------------------
run apt install -y auditd
run systemctl enable rsyslog
run systemctl enable systemd-journald

# -------------------- Apply Changes --------------------
run update-grub
run sysctl -p

# -------------------- Check PAM Modules Debsums --------------------
if ! command -v debsums >/dev/null 2>&1; then
  run apt install -y debsums
fi

if [ -n "$(debsums -s libpam-modules 2>&1)" ]; then
  run apt install --reinstall -y libpam-modules
  if [ -n "$(debsums -s libpam-modules 2>&1)" ]; then
    FAILURES+=("ALERT: libpam-modules still fails debsums after reinstall")
  fi
fi

# -------------------- Permissions --------------------
run chmod 644 /etc/passwd
run chmod 644 /etc/group
run chmod 640 /etc/shadow
run chmod 640 /etc/gshadow
run chmod 440 /etc/sudoers
for f in /etc/sudoers.d/*; do
  [ -e "$f" ] && run chmod 440 "$f"
done
run chmod 644 /etc/crontab
run chmod 644 /etc/login.defs
run chmod 644 /etc/hosts
run chmod 644 /etc/apt/sources.list
run chmod 644 /etc/sysctl.conf
run chmod 755 /home/
run chmod 755 /etc

# -------------------- Closing --------------------
echo
echo "Backups saved to: $BACKUP_DIR"
echo
if [ ${#FAILURES[@]} -eq 0 ]; then
  echo "Success."
else
  echo "Failures:"
  for item in "${FAILURES[@]}"; do
    echo "  - $item"
  done
fi
