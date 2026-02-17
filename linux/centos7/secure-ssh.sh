# !/bin/bash
# secure-ssh.sh
# author dylanverge
# Creates a user, installs SSH public key, disables root + password SSH

set -e

USERNAME="$1"
GITHUB_USER="$2"

if [ -z "$USERNAME" ]; then
  echo "Usage: $0 <username> [github_username]"
  exit 1
fi

# Create user if it doesn't exist
if ! id "$USERNAME" &>/dev/null; then
  sudo useradd -m -s /bin/bash "$USERNAME"
fi

# Create .ssh directory
sudo mkdir -p /home/"$USERNAME"/.ssh
sudo chmod 700 /home/"$USERNAME"/.ssh

AUTHORIZED_KEYS="/home/$USERNAME/.ssh/authorized_keys"

# Add SSH key
if [ -n "$GITHUB_USER" ]; then
  echo "Fetching SSH key from GitHub for $GITHUB_USER"
  curl -fsSL https://github.com/"$GITHUB_USER".keys \
    | sudo tee "$AUTHORIZED_KEYS" > /dev/null
else
  echo "Using local SSH key"
  if [ ! -f "$HOME/.ssh/id_rsa.pub" ] && [ ! -f "$HOME/.ssh/id_ed25519.pub" ]; then
    echo "No local SSH public key found"
    exit 1
  fi

  cat "$HOME"/.ssh/*.pub | sudo tee "$AUTHORIZED_KEYS" > /dev/null
fi

# Permissions
sudo chmod 600 "$AUTHORIZED_KEYS"
sudo chown -R "$USERNAME":"$USERNAME" /home/"$USERNAME"/.ssh

# SSH hardening
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Restart SSH
sudo systemctl restart sshd

echo "Passwordless SSH configured for $USERNAME"
