app.use(compress())

fs = require('co-fs')

let request = require('co-supertest')

'TokenMismatchException'

this.session.destroy()
this.session = null

this.body = yield fs.readFile('1.txt')

#!/usr/bin/env ruby

commands = [
  'sudo apt-get update',
  'sudo apt-get install imagemagick graphicsmagick',
  'sudo apt-get install libmysqlclient-dev',
  'mysql -e "create database IF NOT EXISTS travis_test;" -u travis',
  'mysql -e "show databases;" -u travis',
  'gem install mysql2',
  'bundle update'
]

commands.each { |command| system(command) }

before_install: "ruby script/travis.rb"
before_script: "ruby database/migrate.rb"
script: "mocha mocha/index.js"
rvm: "2.1.4"
env:
  global:
    - DATABASE_HOST="127.0.0.1"
    - DATABASE_NAME="travis_test"
    - DATABASE_USER="travis"
    - DATABASE_PASSWORD=""
