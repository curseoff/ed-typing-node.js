class abstractAdminController extends abstractController
  beforeFilter:
    ["setCurrentUser"]
  
  setCurrentUser: ->
    if @req.session?
      if @req.session.currentUser?
        @currentUser = @req.session.currentUser
  
exports.abstractAdminController = abstractAdminController