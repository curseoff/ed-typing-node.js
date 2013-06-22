class Paginate extends Module
  @include Kernel

  constructor: ()->
    @events = model_events
    @_setSchema()
    
  find: (fields, callback)->
    @events.assign.events.on(@events.countName(), ()=>
      callback()
    )
  
  _setSchema: ()->
    @model = mongoose.model(@class_name(), new Schema(@Schema));

exports.Paginate = Paginate