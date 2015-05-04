class Manage::IndexController < ManageController
  def index
    @navs={
        "快捷导航"=> [
            {text: "系统概览",icon: "dashboard",options:{controller: "index",action: "dashboard"}},
            {text: "个人信息设置",icon: "user",options:{controller: "self",action: "index"}}
        ],
        "省级创新平台"=> [
            {text: "文章管理",icon: "list",options:{controller: "cxpt/mnews",action: "index"}},
        ],
        "管理员管理"=> [
            {text: "管理员列表",icon: "list",options:{controller: "admins",action: "index"}},
            {text: "角色管理",icon: "users",options:{controller: "roles",action: "index"}},
            {text: "权限管理",icon: "key",options:{controller: "nodes",action: "index"}}
        ],
        "学生管理"=> [
            {text: "学生名单",icon: "list",options:{controller:"students",action:"index"}},
            {text: "学院专业设置",icon: "graduation-cap",options:{controller:"professions",action:"index"}},
        ],
        "比赛管理"=> [
            {text: "比赛大类管理",icon: "list",options:{controller: "contests",action: "index"}},
            {text: "举办比赛",icon: "star",options:{controller: "competes",action: "index"}},
            {text: "发布资讯",icon: "newspaper-o",options:{controller: "news",action: "index"}}
        ],
        "系统管理"=> [
            {text: "系统设置",icon: "cog",options:{controller: "configs",action: "index"}},

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
