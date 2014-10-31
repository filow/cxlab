require 'test_helper'

class Manage::RoleTest < ActiveSupport::TestCase

  test "角色属性不能为空" do
   role=Manage::Role.new
   assert role.invalid?
   assert role.errors[:name].any?,role.errors[:name]
   assert role.errors[:remark].any?,role.errors[:remark]
  end

  test "角色名称(name)不能重复" do
    role = Manage::Role.new(:name       => manage_roles(:edit).name,
                            :remark     => "编辑", 
                    	      :is_enabled => 1)
    assert_not role.save,role.errors[:name]
  end
  
end
