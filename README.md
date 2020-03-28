# ProtonVPN-CLI 

### List of all Commands

| **Command**                      | **Description**                                       |
| -------------------------------- | ----------------------------------------------------- |
| `protonvpn init`                 | Initialize ProtonVPN profile.                         |
| `protonvpn connect, c`           | Select a ProtonVPN server and connect to it.          |
| `protonvpn c [servername]`       | Connect to a specified server.                        |
| `protonvpn c -r`                 | Connect to a random server.                           |
| `protonvpn c -f`                 | Connect to the fastest server.                        |
| `protonvpn c --p2p`              | Connect to the fastest P2P server.                    |
| `protonvpn c --cc [countrycode]` | Connect to the fastest server in a specified country. |
| `protonvpn c --sc`               | Connect to the fastest Secure Core server.            |
| `protonvpn reconnect, r`         | Reconnect or connect to the last server used.         |
| `protonvpn disconnect, d`        | Disconnect the current session.                       |
| `protonvpn status, s`            | Print connection status.                              |
| `protonvpn configure`            | Change CLI configuration.                             |
| `protonvpn refresh`              | Refresh OpenVPN configuration and server data.        |
| `protonvpn examples`             | Print example commands.                               |
| `protonvpn --version`            | Display version.                                      |
| `protonvpn --help`               | Show help message.                                    |



## Auto-connect on boot

#### via Systemd Service

Systemd is the current init system of most major Linux distributions. This guide shows you how to use systemd to automatically connect to a  ProtonVPN Server when you boot up your system.

1. Find the location of the executable with `sudo which protonvpn`

   [![which-protonvpn](https://camo.githubusercontent.com/02d16bd1cb282bdf14532684588c83d4b332132e/68747470733a2f2f692e696d6775722e636f6d2f4a6a59707669492e706e67)](https://camo.githubusercontent.com/02d16bd1cb282bdf14532684588c83d4b332132e/68747470733a2f2f692e696d6775722e636f6d2f4a6a59707669492e706e67)

2. Create the unit file in `/etc/systemd/system`

   `sudo nano /etc/systemd/system/protonvpn-autoconnect.service`

3. Add the following contents to this file

   ```
   [Unit]
   Description=ProtonVPN-CLI auto-connect
   Wants=network-online.target
   
   [Service]
   Type=forking
   ExecStart=/usr/local/bin/protonvpn connect -f
   Environment=PVPN_WAIT=300
   Environment=PVPN_DEBUG=1
   Environment=SUDO_USER=user
   
   [Install]
   WantedBy=multi-user.target
   ```

   Make sure to replace the username in the `Environment=SUDO_USER` line with your own username that has ProtonVPN-CLI configured.

   `PVPN_WAIT=300` means that ProtonVPN-CLI will check for  300 Seconds if the internet connection is working before timing out.  Adjust this value as you prefer.

   Also replace the path to the `protonvpn` executable in the `ExecStart=` line with the output of Step 1.

   If you want another connect command than fastest as used in this example, just replace `-f` with what you personally prefer.

4. Reload the systemd configuration

   `sudo systemctl daemon-reload`.

5. Enable the service so it starts on boot

   `sudo systemctl enable protonvpn-autoconnect`

Now ProtonVPN-CLI should connect automatically when you boot up your system.