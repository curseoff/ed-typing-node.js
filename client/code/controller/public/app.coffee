saveData = []

typing = {}

class appController
  event: ->
    ss.event.on("newMessage", (templates)->
      app.render(templates)
    )  
    ss.event.on("quantityMessage", (quantity)->
      html = "(#{quantity})"
      $("#typing_quantity").html(html)
    )

    ss.event.on("loginInfo", (user)->
      if user == null
        alert('メールアドレス。または、パスワードが間違っています。')
      else
        html = ss.tmpl["typing-index"].render({user : user})
        $("#content").html(html)
        load.typing(load.meanSubmit)
        load.saveMeans()
    )
    
  render: (templates)->
    length = templates.length

    for i in [0...length]
      template = templates[i]
      html = ss.tmpl[template.name].render(template.data)
      $(template.id).html(html)
    
app = new appController
app.event() 



load = {
  
}

load.newTypingCount = ()->
  typing = {
    failure: 0 # 失敗数
    word_length: 0 # 入力数
    sentence_count: 0 # 入力文章数
    type_count: 0
    max_type_count: 0
    start_time: null
  }
load.newTypingCount()

load.wordKeyUp = ()->
  $('#word').on('keyup', ->
    $("#typing").off("submit")
    word = $('#word').val()
    
    length = word.length
    index = saveData[0].index

    mean = saveData[0].mean

    mae = mean.slice(0, length)
    if mae == word
      usiro = mean.slice(length)
      mean = "<span class='typing-color'>#{mae}</span>#{usiro}"
      $("#mean_#{index}").html(mean)
      $("#mean_#{index}").css({"border": "1px solid black"})
      typing.word_length = length
      
      if length > typing.max_type_count
        typing.max_type_count = length
        typing.type_count++
        
        if typing.type_count == 1
          typing.start_time = (new Date()).getTime() / 1000
          
          setInterval(()->
            end_time = (new Date()).getTime() / 1000
            minute = ~~(end_time - typing.start_time)

            t = typing.type_count / minute
            m = Math.round(t * 60)

            $('#typing_speed').html("#{m}分/打")
            
            $('#time').html("#{Math.round(minute)}秒")
          ,
          1000)
        else

      
      if length == saveData[0].mean.length
        ss.rpc("typing.updateQuantity", 1)
        saveData.shift()
        $('#word').val("")
        $("#mean_#{index}").remove()
        typing.word_length = 0
        typing.sentence_count++
        typing.max_type_count = 0
        
        
      
    else
      word = word.slice(0, typing.word_length)
      $('#word').val(word)
      typing.failure++
    
    typing_rate = 0
    if typing.type_count == 0
      typing_rate = 0
    else
      typing_rate = Math.round((typing.type_count / (typing.failure + typing.type_count)) * 10000) / 100
    
    $('#sum_typing_count').html("#{typing.type_count}打")
    $('#typing_rate').html("正確率#{typing_rate}%")
    $('#typing_failure').html("#{typing.failure}打")
    
  )
     
load.saveMeans = ()->    
  ss.event.on("saveMeans", (data)->
    saveData = data.means

    load.wordKeyUp()
  )


load.meanSubmit = ()->
  mean = $("#word").val()

  exports.send(mean, (success)->
    if (success)
      $("#word").val("");
  )
        
load.typing = (meanSubmit)->
  $("#typing").on("submit", meanSubmit)



exports.send = (word, cb)->
  words = word.split(' ')
  length = words.length

  if valid(word)
    ss.rpc("typing.sendMessage", word, length)
    return cb(true);
    
  return cb(false);

timestamp = ->
  d = new Date();
  d.getHours() + ":" + pad2(d.getMinutes()) + ":" + pad2(d.getSeconds());

pad2 = (number)->
  return (number < 10 ? "0" : "") + number


valid = (text)->
  return text && text.length > 0;

get_array = (name)->
  array = {}
  $.each($('[name^=' +name+']'), ->
    match = $(this).attr('name').match(/\[(.+)\]/)
    array[match[1]] = $(this).val() 
  )
  array
