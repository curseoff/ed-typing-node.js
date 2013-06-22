global.pp = (obj)->
  line = '-----------------------------------'
  
  output = line + "\n"
  output += timestamp() + "\n"
  output += line + "\n"
  output += util.inspect(obj,false,null) + "\n"

  write_path = "#{path.log_dir}pp.log"
  write = fs.createWriteStream(write_path, {
    'flags': 'a',
    'encoding' : 'UTF8',
    'mode': 777
  })
  write.write(output);


  
global.render = (template, id, data)->
  {name: template, id: id, data: data}

global.timestamp = ->
  moment().strftime("%Y-%m-%d %H:%M:%S")
