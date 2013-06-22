class abstractController extends Module
  initialize: ->
    @assign = {}
    @template = {}
    @models = {}
    @template.element = '#admin_content'
        
    @events = new events.EventEmitter();

  _runFilter: (filterName)->
    if @[filterName]?
      for index, method of @[filterName]
        @[method]()
  
  setReceiveRecords: ()->
    @events.once('receiveRecords', (key, records)=>
      @assign[key] = records
      @events.emit('after')
    )
  
  run: (@req, @res, @ss, @params)->
    @initialize()  
       
    @req.use('session')
    @render(@params)
    
    @_runFilter("beforeFilter")
    
    @[@params.action_name]()
    
    
    @events.once('after', ()=>
      @_runFilter("afterFilter")
      @_render()
    )

    unless @events._events.receiveRecords?
      @events.emit('after')

  _render: ->
    switch @template.mode
      when 'render'
        fs.readFile(@_getTempateName(),"utf8", (err, html)=>
          @template.html = eco.render(html, @assign)
          @ss.publish.socketId(@req.socketId ,'render', @template)
        )
      when 'redirectTo'
        instance_controller = new(require("#{path.root_dir}/server/lib/Controller").Controller)
        instance_controller.run(@req, @res, @ss, @template)
        
  redirectTo: (params)->
    @render(params, 'redirectTo')
    
  render: (params, mode = 'render')->
    @template.controller_name = params.controller_name
    @template.action_name = params.action_name
    
    if params.element?
      @template.element = params.element
    
    @template.mode = mode
    
  _getTempateName: ->
    filename = "#{path.view_dir}admin/#{@template.controller_name}/#{@template.action_name}.html"
    filename
      
exports.abstractController = abstractController
  