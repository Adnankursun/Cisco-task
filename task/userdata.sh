#!/bin/bash
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "<html><h1>Deployed via Terraform  "Cisco SPL" </h1></html>" | sudo tee /var/www/html/index.html
