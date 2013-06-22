class modelEvents
  constructor: ->
    @assign = {}
    @assign.count = 0
    @assign.events = new events.EventEmitter()

  countName: ()->
    count = @assign.count++
    "event_#{count}"
    

exports.modelEvents = modelEvents