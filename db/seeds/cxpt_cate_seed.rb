class CxptCateSeed
  def initialize
    @raw_data = YAML.load(File.read('config/exts/cxpt_nav.yml'))
  end
  def explain
    '更新创新平台文章类别'
  end

  # 删除所有与生成类别无关的信息，并映射到数据库字段
  def filter(data)
    result = []
    data.each do |parent|
      next if parent['is_passage']==false
      obj = {name: parent['text'],display: parent['type'],child: []}
      if parent['type']
        obj[:child]<<{name: '_'+parent['text'],display: parent['type']}
      end
      unless parent['children'].nil?
        parent['children'].each do |child|
          if child['type'] && !child['type'].empty?
            obj[:child]<<{name: child['text'],display: child['type']}
          end
        end
      end
      result << obj
    end
    result
  end
  def run
    # 清空缓存
    cache = Cache.new('cxpt')
    cache[:cate_tree_cache] = nil
    data = filter(@raw_data)
    # 先将数据库中得所有节点的标记位置1
    Cxpt::Cate.update_all "edit_flag=1"

    data.each do |parent|
      #将子节点保存下来并删除源
      children=parent[:child]
      parent.delete :child

      # 更新父节点
      parent_node=update_record(parent)
      # 遍历子节点并重复操作
      if children
        children.each do |child|
          # 子节点会把父节点的名字当做前缀
          update_record(child,parent_node.id)
        end
      end
    end

    # 删除所有没有被操作过的节点
    Cxpt::Cate.where("edit_flag=1").delete_all

  end


  def update_record(item,pid=0)
    # 标记散列
    extra_flag={"edit_flag"=>0,"pid"=>pid}

    # 获取当前数据库中的对应记录
    db_item=Cxpt::Cate.find_by_name(item[:name])

    # 子节点缩进
    print "    [子节点 #pid=#{pid}]" if pid!=0

    # 如果记录存在，就更新记录
    if db_item
      print "\033[1m[更新]\033[0m  记录#{db_item.name}.."
      result=db_item.update item.merge(extra_flag)
      if result
        puts "成功"
      else
        puts "失败"
      end
    else
      # 记录不存在，创建记录
      db_item=Cxpt::Cate.create item.merge(extra_flag)
      puts "\033[36m[添加]\033[0m  记录#{db_item.name}"
    end
    db_item
  end
end