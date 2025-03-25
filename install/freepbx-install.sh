#!/usr/bin/env bash

# Copyright (c) 2021-2025 tteck
# Author: tteck (tteckster)
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

source /dev/stdin <<<"$(curl -sSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/install.func)"
export DEBIAN_FRONTEND=noninteractive

# Update and install prerequisites
msg_info "Updating system and installing prerequisites"
$STD apt-get update
$STD apt-get install -y wget git curl

# Download the official FreePBX installation script
msg_info "Downloading the official FreePBX installation script"
$STD wget https://github.com/FreePBX/sng_freepbx_debian_install/raw/master/sng_freepbx_debian_install.sh -O /tmp/sng_freepbx_debian_install.sh
$STD chmod +x /tmp/sng_freepbx_debian_install.sh

# Create log directory
mkdir -p /var/log/pbx

# Execute the official FreePBX installation script
msg_info "Starting FreePBX installation (this will take some time)"
msg_info "Installation logs will be available at /var/log/pbx/freepbx17-install.log"
$STD bash /tmp/sng_freepbx_debian_install.sh

# Get IP
IP=$(hostname -I | awk '{print $1}')

msg_ok "FreePBX has been installed successfully!"
echo -e "\n"
echo -e "Access FreePBX at: http://${IP}"
echo -e "Complete the setup through the web interface"
echo -e "Installation logs are available at: /var/log/pbx/freepbx17-install.log"

exit 0