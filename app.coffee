http = require('http')
ss = require('socketstream')

global.path = 
  root_dir:
     "#{__dirname}/"

require('./server/init')

ss.client.define('public', {
  view: 'layout/application.html',
  css:  ['libs', 'public'],
  code: ['libs', 'controller/abstract', 'controller/public'],
  tmpl: '*'
})

ss.client.define('admin', {
  view: 'layout/admin.html',
  css:  ['libs', 'admin'],
  code: ['libs/jquery.min.js', 'libs/davis.min.js', 'controller/abstract', 'controller/admin'],
  tmpl: '*'
})

ss.http.route('/', (req, res)->
  res.serveClient('public')
)

ss.http.route('/admin', (req, res)->
  res.serveClient('admin')
)

ss.client.formatters.add(require('ss-coffee'))
ss.client.formatters.add(require('ss-stylus'))
ss.client.templateEngine.use(require('ss-hogan'));

if (ss.env == 'production')
  ss.client.packAssets()

server = http.Server(ss.http.middleware);
server.listen(config.server.port);

ss.start(server)

process.on('uncaughtException', (err)->
  console.log err.stack
)