class Manage::IndexController < ManageController
  def index
    @navs={
        "快捷导航"=> [
            {text: "系统概览",icon: "dashboard",options:{controller: "index",action: "dashboard"}},
        ],
        "管理员管理"=> [
            {text: "管理员列表",icon: "list",options:{controller: "admins",action: "index"}},
            {text: "角色管理",icon: "user",options:{controller: "roles",action: "index"}},
            {text: "权限管理",icon: "key",options:{controller: "nodes",action: "index"}}
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
    # 从系统中获取版本库提交信息
    commit_log = `git log --pretty=format:"%h|%an|%ad|%s"`
    # 取前10条输出
    @commit_log = []
    commit_log.split(/\n/)[0,10].each do |log|
        info = log.split(/\|/)
        info_in_hash = {id: info[0],
                        author: info[1], 
                        date: Time.parse(info[2]),
                        message: info[3]}
        @commit_log << info_in_hash
    end

    @tasks = YAML.load(File.read("config/task_board.yml"))
  end
end
