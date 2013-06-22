class Controller
  run: (req, res, ss, params)->

    try
      instance_controller = new (require("../controller/admin/#{params.controller_name}Controller")["#{params.controller_name}Controller"])
      instance_controller.run(req, res, ss, params)

    catch error
      console.log error.stack
      
exports.Controller = Controller