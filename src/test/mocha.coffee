should = require 'should'
request = require 'supertest'
_server = require '../../server'

server = _server.listen()

(require './404') server, request
(require './home') server, request
(require './user') server, request
(require './topic') server, request
(require './session') server, request
(require './admin/user') server, request
