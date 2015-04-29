require 'test_helper'

class Manage::RoleTest < ActiveSupport::TestCase

  # 一个新的role的数据记录，其各字段均为空
  # 由于role模型对数据有验证，不能存入roles表

  test "角色属性不能为空" do
   role=Manage::Role.new
   assert role.invalid?
   assert role.errors[:name].any?,role.errors[:name]
   assert role.errors[:remark].any?,role.errors[:remark]
  end

  # 一个新的role的数据记录，其各字段如下所示
  # 验证角色名称不重复的检查机制是否正确运行

  test "角色名称(name)不能重复" do
    role = Manage::Role.new(:name       => manage_roles(:edit).name,
                            :remark     => "编辑", 
                    	      :is_enabled => 1)
    assert_not role.save,role.errors[:name]
  end
  
end
