class Manage::IndexController < ManageController
  def index
    @navs={
        "快捷导航"=> [
            {text: "系统概览",icon: "dashboard",options:{controller: "index",action: "dashboard"}},
        ],
        "管理员管理"=> [
            {text: "管理员列表",icon: "list",options:{controller: "admins",action: "index"}},
            {text: "角色管理",icon: "user",options:{controller: "roles",action: "index"}}
        ],
        "系统管理"=> [
            {text: "系统设置",icon: "cog",options:{controller: "configs",action: "index"}},

        ],
        "测试子目录"=>[
            {text:"父目录",icon: "list",children:[
                {text: "子目录",icon: "list",options:{controller: "index",action: "dashboard"}}
                ]}
                
        ]
    }
    render layout: false
  end

  def dashboard

  end
end
