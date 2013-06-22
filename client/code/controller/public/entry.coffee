window.ss = require('socketstream')
abstract_controller = require('./abstractController').abstractController

class entryController extends abstract_controller
  constructor: ->

    ss.server.on('disconnect', ->
      console.log('Connection down :-(')
    )
    
    ss.server.on('reconnect', ->
      console.log('Connection back up :-)')
    )

    ss.server.on('ready', ->
      require('/app')
      abstract_controller.render('account-login')
    )


    
  account_new_account: ()->
    load.new_account()
    
  account_login: ()->
    load.click_new_account()
    

entry_controller = new entryController()
abstract_controller.setController(entry_controller)



load = {}


  

load.click_new_account = ()->
  # アカウント新規作成
  load.newAccount()
  load.account()  
  
load.new_account = ()->  
    $('#new_account').on("submit", ->
      account = get_array('account')
      
      for key, value of account
        if value == ""
          alert "#{key}が入力されていません。"
          return false
      
      ss.rpc("account.create", account)
    )
    
load.newAccount = ()->
 ss.event.on("newAccount", (user)->
   if user == null
     alert 'アカウント作成に失敗しました'
   else
     abstract_controller.render('account-login')
     alert 'アカウントを作成しました'     
 )
 
load.account = ()->
  # ログイン認証
  $('#account').on("submit", ->
    account = get_array('account')

    ss.rpc("account.login", account)
  )
 
get_array = (name)->
  array = {}
  $.each($('[name^=' +name+']'), ->
    match = $(this).attr('name').match(/\[(.+)\]/)
    array[match[1]] = $(this).val() 
  )
  array

