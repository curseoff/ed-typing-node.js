class abstractController
  setController: (@controller)->

  render: (name, id = "#content")->

    html = ss.tmpl[name].render()
    $(id).html(html)

    @set_link()
    @loadScript name

  set_link: ()->

    $('a').each(->
      element = $(this)
      templete = element.attr('href').split('/').slice(1).join('-')
      
      $(this).on('click', ->
        abstract_controller.render(templete)
        return false
      )
    )
  
  loadScript: (name)->
    actionName = name.replace('-', '_');

    if @controller[actionName] != undefined
     @controller[actionName]()
     
abstract_controller = new abstractController()
exports.abstractController = abstract_controller
