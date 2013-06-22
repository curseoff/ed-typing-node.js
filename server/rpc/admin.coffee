exports.actions = (req, res, ss)->
  return action: (controller_name, action_name, params)->
      unless params.controller?
        params.controller_name = controller_name
        params.action_name = action_name
        
      instance_controller = new(require("#{ss.root}/server/lib/Controller").Controller)
      instance_controller.run(req, res, ss, params)
