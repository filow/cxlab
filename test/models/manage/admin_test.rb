require 'test_helper'

class Manage::AdminTest < ActiveSupport::TestCase


  # 一个新的admin的数据记录，其各字段均为空
  # 由于admin模型对数据有验证，不能存入admins表

  test "管理员属性不能为空" do
    admin=Manage::Admin.new
    assert admin.invalid?
    assert admin.errors[:uid].any?,admin.errors[:uid]
    assert admin.errors[:nickname].any?,admin.errors[:nickname]
  end


  # email格式验证
  # 要求符合 /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  test "email格式" do
    ok = %w{ 142064699@qq.com fr_1ed@gmail.com fred@sina.com FRED@163.com 
           		ABC13a@123.com abcdf@QQ.COM 1313*~&abc@qq.com}
    bad = %w{ 142ABC@A abcdef fred@qq_com }
  
    admin = Manage::Admin.new(:uid        => "admin1",
                              :nickname   => "管理员",
                              :is_enabled => 1,
                              :desc       => "管理员",
                              :password   =>"123456789")
    ok.each do |email|
        admin.email=email
        assert admin.valid?, admin.errors.full_messages
    end

    bad.each do |email|
         admin.email=email
         assert admin.invalid?, "saving #{email}"
    end
  end
  
end
