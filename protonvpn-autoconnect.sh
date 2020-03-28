# Create file protonvpn-autoconnect.service
# Requires: Install and Initialize protonvpn-cli
# Ref: https://github.com/ProtonVPN/protonvpn-cli-ng/blob/master/USAGE.md
# Ref 2: https://protonvpn.com/support/linux-vpn-tool/
sudo tee /etc/systemd/system/protonvpn-autoconnect.service <<EOF
[Unit]
Description=ProtonVPN CLI Auto-Start
After=network-online.target
# Wants=network-online.target

[Service]
Type=forking
Environment=SUDO_USER=<mysudoeruser>
# Environment=PVPN_DEBUG=1
Environment=PVPN_WAIT=10
ExecStart=/usr/local/bin/protonvpn c --cc es
ExecReload=/usr/local/bin/protonvpn c --cc es
ExecStop=/usr/local/bin/protonvpn disconnect
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# sudo chmod +x /etc/systemd/system/protonvpn-autoconnect.service

# sudo systemctl daemon-reload

# sudo systemctl enable protonvpn-autoconnect.service

# sudo systemctl start protonvpn-autoconnect.service

# sudo systemctl status protonvpn-autoconnect.service
