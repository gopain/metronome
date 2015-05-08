#!/usr/bin/env bash

sudo apt-get update
# sudo apt-get upgrade --show-upgraded

sudo apt-get install build-essential python-software-properties

sudo apt-get install curl wget git-core
sudo apt-get install vim tree

sudo apt-get install libssl-dev
sudo apt-get install mysql-server

sudo apt-get install imagemagick graphicsmagick

# Update Ruby to 2.1
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install ruby2.1
sudo gem install bundler

# Install NodeJS
sudo apt-get install npm
sudo npm install -g n
sudo n latest

bundle install

sudo npm install
sudo npm install -g pm2
sudo npm install -g gulp
sudo npm install -g mocha
sudo npm install -g nodemon

sudo apt-get install libmysqlclient-dev

exit 0
