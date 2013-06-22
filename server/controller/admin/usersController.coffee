class usersController extends abstractAdminController
  index: ()->
    @setReceiveRecords()
    User.users(@events)
    
exports.usersController = usersController