var path = require('path');
var root = __dirname.slice(0, -13);

require('coffee-script/register');

var config = require(path.join(root, 'src', 'config'))(path, root);
var knex   = require('knex')(config.knex.development);

require(config.path.tables)(knex, config, path);
