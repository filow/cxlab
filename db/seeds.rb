# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 使用lambda包装，防止设立全局变量污染运行环境
lambda {

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
puts "开始更新权限节点信息...."
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

}.call







# config的lambda包装
lambda {

def update_config_type(key)
    # 获取当前数据库中的对应记录
    db_item=Manage::ConfigType.find_by_name(key)
    # 如果记录存在，就更新记录
    if db_item
        print "ConfigType:#{db_item.name}.."
        result=db_item.update edit_flag: 0
        if result
            puts "成功"
        else
            puts "失败"
        end
    else
        # 记录不存在，创建记录
        db_item=Manage::ConfigType.create name: key
        puts "\033[36m[添加]\033[0m  ConfigType:#{db_item.name}"
    end
    return db_item
end
def update_config(parent,key,val)
    # 标记散列
    extra_flag={"edit_flag"=>0}

    key = parent.name + '_' + key.to_s
    # 获取当前数据库中的对应记录
    db_item=Manage::Config.find_by_key(key)

    # 子节点缩进
    print "    [子节点]"

    # 如果记录存在，就更新记录
    if db_item
        print "\033[1m[更新]\033[0m  记录#{db_item.key}.."
        
        result=db_item.update field_type: val["field_type"],edit_flag: false
        if result
            puts "成功"
        else
            puts "失败"
        end
    else
        # 记录不存在，创建记录
        db_item=Manage::Config.create val.merge({"key"=>key})
        if db_item.errors.any?
            puts "\033[36m[添加]\033[0m  记录#{db_item.key}Fail"
            puts db_item.errors.full_messages.join("\n")
        else
            parent.configs << db_item
            puts "\033[36m[添加]\033[0m  记录#{db_item.key}:#{db_item.value}"
        end
        
    end
    return db_item
end
puts "开始更新Config信息...."
# 加载配置文件
configs = YAML.load(File.read("config/app_config.yml"))

# 先将数据库中得所有节点的标记位置1
Manage::Config.update_all "edit_flag=1"
Manage::ConfigType.update_all "edit_flag=1"

# 遍历所有节点，如果节点已经存在，则更新字段，否则创建字段
configs.each do |key,children|
    
    parent_node = update_config_type(key)

    # 遍历子节点并重复操作
    children.each do |child_k,child_v|
        # 子节点会把父节点的名字当做前缀
        update_config(parent_node,child_k,child_v)
    end
end

# 删除所有没有被操作过的节点
Manage::Config.where("edit_flag=1").delete_all
Manage::ConfigType.where("edit_flag=1").delete_all

}.call