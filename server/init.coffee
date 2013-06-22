require('../config/application')
require("./lib/path")
require("./function/common")

global.eco = require('eco')
global.fs = require('fs')
global.async = require('async')
global.moment = require('moment-strftime')
global.util = require('util')
global.events = require('events')

global.mongoose = require('mongoose');
mongoose.connect("mongodb://localhost/#{config.database.db_name}");
global.Schema = mongoose.Schema;

global.Module = require('./lib/Module').Module
global.Kernel = require('./lib/Kernel').Kernel
global.model_events = new(require('./lib/modelEvents').modelEvents)
global.Paginate = require('./lib/Paginate').Paginate


global.User = require("./model/User").User
global.UserTyping = require("./model/UserTyping").UserTyping
global.English = require("./model/English").English
global.Room = require("./model/Room").Room
global.UserRoom = require("./model/UserRoom").UserRoom



global.abstractController = require('./controller/abstract/abstractController').abstractController
global.abstractAdminController = require('./controller/abstract/abstractAdminController').abstractAdminController