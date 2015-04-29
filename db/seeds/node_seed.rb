class NodeSeed
  def initialize
  end

  def explain
    '更新权限节点信息'
  end

  def run
    # 加载配置文件
    nodes = YAML.load(File.read("config/nodes.yml"))

    # 先将数据库中得所有节点的标记位置1
    Manage::Node.update_all "edit_flag=1"

    parent_sort=0
    # 遍历所有节点，如果节点已经存在，则更新字段，否则创建字段
    nodes.each do |key,val|

      #将子节点保存下来并删除源
      children=val["children"]
      val.delete "children"

      # 更新父节点
      parent_node=update_record(key,val,parent_sort)
      parent_sort+=1

      # 遍历子节点并重复操作
      if children
        child_sort=0
        children.each do |child_k,child_v|
          # 子节点会把父节点的名字当做前缀
          update_record(parent_node.name + '_' + child_k,child_v,child_sort,parent_node.id)
          child_sort+=1
        end
      end
    end

    # 删除所有没有被操作过的节点
    Manage::Node.where("edit_flag=1").delete_all

  end

  def update_record(key,val,sort,pid=0)
    # 标记散列
    extra_flag={"edit_flag"=>0,"pid"=>pid,"sort"=>sort}

    # 获取当前数据库中的对应记录
    db_item=Manage::Node.find_by_name(key)

    # 子节点缩进
    print "    [子节点 #pid=#{pid}]" if pid!=0

    # 如果记录存在，就更新记录
    if db_item
      print "\033[1m[更新]\033[0m  记录#{db_item.name}.."
      result=db_item.update val.merge(extra_flag)
      if result
        puts "成功"
      else
        puts "失败"
      end
    else
      # 记录不存在，创建记录
      db_item=Manage::Node.create val.merge({"name"=>key}).merge(extra_flag)
      puts "\033[36m[添加]\033[0m  记录#{db_item.name}:#{db_item.title}"
    end
    return db_item
  end
end