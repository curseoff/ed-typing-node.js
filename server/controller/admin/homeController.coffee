class homeController extends abstractAdminController
  index: ()->

  menus: ()->
    @assign = {
      element_name: '#admin_menu'
      link_to: (menu)->
        url  = menu.url
        name = @escape menu.title
        @safe "<a href='#{url}'>#{name}</a>"
      menus: [
        {title: "ユーザー一覧", url: "/admin/users/index"}
        {title: "ログアウト", url: "/admin/account/logout"}
      ]
    }
exports.homeController = homeController