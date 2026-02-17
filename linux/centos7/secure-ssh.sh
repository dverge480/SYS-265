#code



# Check if username argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USER=$1
KEY_PATH="/home/dylan/SYS-265/linux/public-keys/id_rsa.pub"


sudo useradd -m -s /bin/bash "$USER"
sudo mkdir -p "/home/$USER/.ssh"


if [ -f "$KEY_PATH" ]; then
    sudo cp "$KEY_PATH" "/home/$USER/.ssh/authorized_keys"
else
    echo "Error: Public key not found at $KEY_PATH"
    exit 1
fi

sudo chmod 700 "/home/$USER/.ssh"
sudo chmod 600 "/home/$USER/.ssh/authorized_keys"
sudo chown -R "$USER:$USER" "/home/$USER/.ssh"


if grep -q "PermitRootLogin" /etc/ssh/sshd_config; then
    sudo sed -i 's/.*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
else
    echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config
fi


# 6. Restart SSH
sudo systemctl restart ssh
