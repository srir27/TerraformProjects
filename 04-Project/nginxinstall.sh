#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx 

#echo "<html> <body> <h1> Nginx installed </h1> </body> </html>" > /var/www/html/index.html
echo "<html> <body> <h1> Nginx installed </h1> </body> </html>" | sudo tee /var/www/html/index.html

sudo systemctl start nginx
sudo systemctl enable nginx

# # Print nginx status
# sudo systemctl status nginx



