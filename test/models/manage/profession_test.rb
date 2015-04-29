require 'test_helper'

class Manage::ProfessionTest < ActiveSupport::TestCase

  # 外键约束能力测试

  test "删除学院测试" do
  	#计算机学院下有两个专业,因而不能删除
    computer_colleage=manage_professions(:computer_colleage)
    assert_not computer_colleage.destroy,"错误：删除了有专业的学院"
    #外语院下没有专业,因而可以删除
    foreign_colleage=manage_professions(:foreign_colleage)
    assert foreign_colleage.destroy
  end
end
