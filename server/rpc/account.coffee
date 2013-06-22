exports.actions = (req, res, ss)->
  req.use('session')

  return {
    login: (account)->

      email = account.email
      User.findOne({email: email}, (err,user)->
        ss.publish.socketId(req.socketId ,'loginInfo', user);
        req.session.user = user 
        delete req.session.means
        delete req.session.word
        
        req.session.save((err)->
        
        )        
      )


    ,
    create: (account)->
      User.findOne({email: account.email}, (err, user)->

        if user == null
          user = new User()
          user.email = account.email
          user.name = account.name
          user.quantity = 0
          user.save((err)->
             
          )

          ss.publish.socketId(req.socketId ,'newAccount', user);
        else
          ss.publish.socketId(req.socketId ,'newAccount', null);  
      )
  }
  
