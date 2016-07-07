#! /bin/sh
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev vim -y

cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

rbenv install 2.2.3
rbenv global 2.2.3
ruby -v

echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler

git config --global color.ui true
git config --global user.name "DonaNobisPacem"
git config --global user.email "johnthomasraphael@yahoo.com"
ssh-keygen -t rsa -C "johnthomasraphael@yahoo.com"

cat ~/.ssh/id_rsa.pub

ssh -T git@github.com

curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs

gem install rails -v 4.2.4

rbenv rehash

rails -v

sudo apt-get install mysql-server mysql-client libmysqlclient-dev -y
sudo apt-get install imagemagick php5-imagick -y

sudo apt-get install openjdk-7-jre -y
wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.deb
sudo dpkg -i elasticsearch-1.7.2.deb
sudo update-rc.d elasticsearch defaults
sudo service elasticsearch start

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates

# Add our APT repository
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

# Install Passenger + Nginx
sudo apt-get install -y nginx-extras passenger

sudo vim /etc/nginx/nginx.conf

passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
passenger_ruby /home/sysadmin/.rbenv/shims/ruby; # If you use rbenv

sudo vim /etc/nginx/sites-available/default

# listen 80 default_server;
# listen [::]:80 default_server ipv6only=on;

sudo vim /etc/nginx/sites-available/testapp

server {
  listen 80 default_server;
  server_name dcares.up-ovpd.ph;
  passenger_enabled on;
  rails_env production;
  client_max_body_size 0;
  root /home/sysadmin/dcaresv2/current/public;
}

sudo ln -s /etc/nginx/sites-available/testapp /etc/nginx/sites-enabled/testapp
sudo nginx -s reload

CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ;

scp config/application.yml up_beta:/home/sysadmin/docudb/shared/config/application.yml
scp config/database.yml up_beta:/home/sysadmin/docudb/shared/config/database.yml
scp config/secrets.yml up_beta:/home/sysadmin/docudb/shared/config/secrets.yml

#nameserver bullshit shenanigans
sudo vim /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
