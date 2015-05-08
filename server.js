'use strict';

let koa        = require('koa');
let path       = require('path');
let i18n       = require('i18n');
let csrf       = require('koa-csrf');
let views      = require('koa-views');
let flash      = require('koa-flash');
let serve      = require('koa-static');
let logger     = require('koa-logger');
let _router    = require('koa-router');
let session    = require('koa-session');
let passport   = require('koa-passport');
let compress   = require('koa-compress');
let bodyParser = require('koa-bodyparser');
let override   = require('koa-methodoverride');

require('dotenv').load();
require('coffee-script/register');

let server = koa();
let router = _router();
let config = require(path.join(__dirname, 'src', 'config'))(path, __dirname);

server.keys = config.keys.concat('koa.session');

server.use(bodyParser());
server.use(override(config._method));
server.use(serve('static'));
server.use(session(server));
server.use(logger());
server.use(flash());
server.use(csrf());

server.use(views(config.path.views, config.view));
server.use(passport.initialize());
server.use(passport.session());

require(config.path.index)(server, i18n, config);
require(config.path.server)(router, passport, config);

server.use(router.routes());

if (server.env !== 'test') server.listen(3000);

module.exports = server;
