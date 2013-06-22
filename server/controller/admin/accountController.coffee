class accountController extends abstractAdminController
  login: ()->
    
  create: ()->
    account = @params.account

    if account.name == 'admin' and account.password == 'stable'
      @req.session ||= {}

      @req.session.currentUser =
        user:
          name:
            account.name
  
      @redirectTo({controller_name: 'home', action_name: 'index'})
    else
      @redirectTo({controller_name: 'account', action_name: 'login'})

exports.accountController = accountController