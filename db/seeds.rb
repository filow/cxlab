# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 加载配置文件

puts "开始更新权限节点信息...."
nodes = YAML.load(File.read("config/nodes.yml"))
nodes.each do |key,val|
    db_item=Manage::Node.find_by_name(key)
    if db_item
        print "更新记录#{db_item.name}.."
        result=db_item.update(val)
        if result
            puts "成功"
        else
            puts "失败"
        end
    else
        Manage::Node.create(val.merge({"name"=>key}))
        puts "添加记录#{result.name}:#{result.title}"
    end
end
