process.env.NODE_ENV = 'test';

require('coffee-script/register');
require([__dirname, 'mocha'].join('/'));
