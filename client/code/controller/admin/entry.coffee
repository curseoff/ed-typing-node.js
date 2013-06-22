window.ss = require('socketstream')

ss.server.on('disconnect', ->
  console.log('Connection down :-(')
)
    
ss.server.on('reconnect', ->
  console.log('Connection back up :-)')
)

ss.server.on('ready', ->
  send('account', 'login')
)

ss.event.on("render", (template)->
  render(template)
)

render = (template)->
  $(template.element).html(template.html)

send = (controller_name, action_name, params = {})->
  ss.rpc("admin.action", controller_name, action_name, params)

app = Davis(->
  @get('/admin/:controller_name/:action_name', (request)->
    send(request.params.controller_name, request.params.action_name, request.params)
  )
  
  @post('/admin/:controller_name/:action_name', (request)->
    send(request.params.controller_name, request.params.action_name, request.params)
  )
)
