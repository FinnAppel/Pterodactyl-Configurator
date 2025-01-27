#!/bin/bash

display_menu() {
  clear
  echo "========================="
  echo "   Pterodactyl Configurator"
  echo "   Made by FinnAppel"
  echo "========================="
  echo "1) Change Domain / IP"
  echo "2) Exit"
  echo "========================="
  read -p "Choose an option: " choice
  case $choice in
    1) change_domain_or_ip ;;
    2) exit 0 ;;
    *) echo "Invalid option"; sleep 2; display_menu ;;
  esac
}

change_domain_or_ip() {
  echo "Would you like to configure your web server with a domain or an IP?"
  echo "1) Domain"
  echo "2) IP"
  read -p "Select an option: " option

  case $option in
    1)
      echo "Would you like SSL (https) or Non-SSL (http)?"
      echo "1) SSL"
      echo "2) Non-SSL"
      read -p "Select an option: " ssl_option
      case $ssl_option in
        1) configure_ssl_domain ;;
        2) configure_nonssl_domain ;;
        *) echo "Invalid option"; sleep 2; change_domain_or_ip ;;
      esac
      ;;
    2)
      configure_ip ;;
    *)
      echo "Invalid option"; sleep 2; change_domain_or_ip ;;
  esac
}

configure_ip() {
  read -p "Enter the IP address: " ip

  echo "Stopping Nginx..."
  sudo systemctl stop nginx > /dev/null 2>&1

  echo "Removing old Nginx configuration..."
  sudo rm -f /etc/nginx/sites-available/pterodactyl.conf > /dev/null 2>&1

  echo "Downloading new configuration..."
  sudo curl -o /etc/nginx/sites-available/pterodactyl.conf https://raw.githubusercontent.com/FinnAppel/Pterodactyl-Configurator/refs/heads/main/config/nginx-nonssl.conf > /dev/null 2>&1

  echo "Updating configuration with IP..."
  sudo sed -i "s/<domain>/$ip/g" /etc/nginx/sites-available/pterodactyl.conf > /dev/null 2>&1

  echo "Starting Nginx..."
  sudo systemctl start nginx > /dev/null 2>&1

  echo "Configuration updated successfully!"
  sleep 2
  display_menu
}

configure_nonssl_domain() {
  read -p "Enter the domain (e.g., yourdomain.com): " domain

  echo "Stopping Nginx..."
  sudo systemctl stop nginx > /dev/null 2>&1

  echo "Removing old Nginx configuration..."
  sudo rm -f /etc/nginx/sites-available/pterodactyl.conf > /dev/null 2>&1

  echo "Downloading new configuration..."
  sudo curl -o /etc/nginx/sites-available/pterodactyl.conf https://raw.githubusercontent.com/FinnAppel/Pterodactyl-Configurator/refs/heads/main/config/nginx-nonssl.conf > /dev/null 2>&1

  echo "Updating configuration with domain..."
  sudo sed -i "s/<domain>/$domain/g" /etc/nginx/sites-available/pterodactyl.conf > /dev/null 2>&1

  echo "Starting Nginx..."
  sudo systemctl start nginx > /dev/null 2>&1

  echo "Configuration updated successfully!"
  sleep 2
  display_menu
}

configure_ssl_domain() {
  read -p "Enter the domain (e.g., yourdomain.com): " domain

  echo "Installing Certbot..."
  sudo apt update > /dev/null 2>&1 && sudo apt install -y python3-certbot-nginx > /dev/null 2>&1

  echo "Obtaining SSL certificate..."
  sudo certbot certonly --nginx -d "$domain" > /dev/null 2>&1

  if [ $? -eq 0 ]; then
    echo "Stopping Nginx..."
    sudo systemctl stop nginx > /dev/null 2>&1

    echo "Removing old Nginx configuration..."
    sudo rm -f /etc/nginx/sites-available/pterodactyl.conf > /dev/null 2>&1

    echo "Downloading new SSL configuration..."
    sudo curl -o /etc/nginx/sites-available/pterodactyl.conf https://raw.githubusercontent.com/FinnAppel/Pterodactyl-Configurator/refs/heads/main/config/nginx-ssl.conf > /dev/null 2>&1

    echo "Updating configuration with domain..."
    sudo sed -i "s/<domain>/$domain/g" /etc/nginx/sites-available/pterodactyl.conf > /dev/null 2>&1

    echo "Starting Nginx..."
    sudo systemctl start nginx > /dev/null 2>&1

    echo "Configuration updated successfully with SSL!"
  else
    echo "Failed to obtain SSL certificate. Please check the domain and try again."
  fi

  sleep 2
  display_menu
}

display_menu
