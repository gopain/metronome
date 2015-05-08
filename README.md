# Metronome

Forum Application Using Koa Framework and CoffeeScript

### Requirement

1. Ruby 2.1.*
2. Node 0.12.*
3. Imagemagick or Graphicsmagick
4. MySQL

### Installation

```
bash support/install.sh
bash support/fetch.rb
gulp prepare
```

### Development

```
node src/database/knex.js
mocha src/test/index.js --harmony
nodemon --harmony server.js -e coffee js
```

### License

[The MIT License](https://github.com/mmruby/metronome/blob/master/License.txt)
