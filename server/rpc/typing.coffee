# Server-side Code

# Define actions which can be called from the client using ss.rpc('demo.ACTIONNAME', param1, param2...)
exports.actions = (req, res, ss)->
  class typingController
    sendMessage: (word, length)->
      if req.session.means == undefined || req.session.means.length == 0
        sendMean(req, res, ss, word)
        
    updateQuantity: (quantity)->
      sendQuantity(req, res, ss, quantity)
        
  # Example of pre-loading sessions into req.session using internal middleware
  req.use('session')

  # Uncomment line below to use the middleware defined in server/middleware/example
  # req.use('example.authenticated')
  
  return (new typingController)
    
check = (text, mean, i)->
  min = mean.length

  copy = ""
  count = 0
  is_match = true
  for i in [0...min]
    if(text[i] == mean[i])
      count++
    else 
      is_match = false
      
    if is_match == false
      copy += mean[i]

  return {mean: copy, index: i}

sendQuantity = (req, res, ss, quantity)->
      user = req.session.user
      req.use('session')
      
      word = req.session.word


      if user != undefined
        UserTyping.findOne({user_id: user._id, word: word}, (err, user_typing)->
            match_i = 0
            
            if user_typing == null
              user_typing = new UserTyping();
              user_typing.user_id = user._id
              user_typing.quantity = quantity;
              user_typing.word = word;
              user_typing.save((err)->
                if err
                  pp err
              )

            else
                user_typing.quantity = user_typing.quantity + quantity
                user_typing.save((err)->
                  if err
                   pp err
                )

            ss.publish.socketId(req.socketId ,'quantityMessage', user_typing.quantity)            
        )
        
sendMean = (req, res, ss, word)->
  http = require('http')
  
  if word == req.session.word
    return
  
  req.session.word = word
  req.session.save((err)->
        
  )
  
  options = {
    host: 'www.google.com',
    path: "/dictionary/json?callback=m&q=" + word + "&sl=en&tl=en&restrict=pr,de&client=te",
  }

  http.get(options, (res)->

    if res.statusCode == 200
      response = ""
      res.setEncoding('utf8')
      res.on('data', (chunk)->
        response += chunk          
      )

      res.on('end', ->
        
        m = (json, status, res)->
          webDefinitions = json.webDefinitions

          if webDefinitions == undefined
          
          else
            entries = webDefinitions[0].entries
            means = []
            n = 0;
            
            for i in [0..entries.length]
              if entries[i] == undefined
              
              else if entries[i].type == "meaning"
                terms = entries[i].terms;
                mean = terms[0].text
    
                mean = mean.replace(/&.+?;/g, '').replace(/\(.+?\)/g, '')
     
                
                means[n] = {
                  index: n,
                  mean: mean
                  length: mean.length,
                  match: 0,
                  id : ->
                    return "mean_" + this.index 
                }

                n++

            return means

        data = {
          message: word,
          means: eval(response),
          time: timestamp()
          }
        
        if data.means == undefined
          return

        templates = []
        templates[0] = render("typing-mean","#mean", data)
        templates[1] = render("typing-status","#typing-status", data)

        ss.publish.socketId(req.socketId ,'newMessage', templates)
        ss.publish.socketId(req.socketId ,'saveMeans', data)
        
        req.session.means = data.means
        req.session.save((err)->
          if err
            pp err
        )
        
        sendQuantity(req, res, ss, 0)
      )
  )

html_unescape = (text)->
  match = text.match(/&.+?;/g)
  
  if text != null
    1
   
   
  return text