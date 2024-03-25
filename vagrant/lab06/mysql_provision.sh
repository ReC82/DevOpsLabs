sudo apt-get update
sudo apt-get install -y mysql-server

sudo mysql <<EOF
CREATE USER 'vagrant'@'10.0.5.10' IDENTIFIED WITH mysql_native_password BY 'vagrant';
GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'10.0.5.10' WITH GRANT OPTION;
quit
EOF

sudo sed -i '/^user\s*=\s*mysql/a default_authentication_plugin = mysql_native_password' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^bind-address\s*=\s*127\.0\.0\.1$/bind-address = 10.0.5.20/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql.service