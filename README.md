# Pterodactyl Configuration Script

This script simplifies configuring your Pterodactyl panel, allowing you to easily change the domain or IP address. 
If a domain is provided, it will automatically set up SSL using Let's Encrypt, with no hassle. 
Future updates will add more management features.


## Features

- Change the panel's domain or IP address.
- Ask whether the domain should use SSL or not.
- Automatically configure SSL for your domain using Let's Encrypt.
- Simple and easy-to-use interface.

```bash
curl -sSL https://raw.githubusercontent.com/FinnAppel/Pterodactyl-Configurator/refs/heads/main/configurator.sh | sudo bash
```
_Note: On some systems, it's required to be already logged in as root before executing the one-line command (where `sudo` is in front of the command does not work)._

## Upcoming Features

- **Wings Updater**: Automatically update the Wings daemon.
- **Panel Updater**: Simplify the process of updating the Pterodactyl panel.
- **Maintenance Mode Toggle**: Enable or disable maintenance mode for the panel.
- And more...

## Supported Linux (Unix) OS

| Linux Distro | Supported Versions | Support          |
| ------------ | ------------------ | ---------------- |
| Ubuntu       | 22.04, 24.04       | ✅ Supported |
| Debian       | None               | :x: Unsupported  |
| CentOS       | None               | :x: Unsupported  |
