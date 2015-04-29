
# 遍历seed目录，寻找其中所有的以seed.rb结尾的文件并加载，随后运行这些文件

# 加载文件
Dir.glob('db/seeds/*').each do |file|
  require "#{Rails.root}/#{file}" if file =~ /seed.rb\z/
end

single = false

if single
  seed_classes = [:CxptCateSeed]
else
  # 从当前常量表中选出以Seed结尾的常量
  seed_classes = self.class.constants.select{|n| n=~ /Seed\z/}
end

# 遍历常量并生成对象，运行其中的run方法
seed_classes.each do |class_sym|
  con = self.class.const_get(class_sym)
  inst = con.send(:new)
  puts "=======  #{inst.explain}  =======" if con.method_defined?(:explain)
  inst.run if con.method_defined?(:run)
end
