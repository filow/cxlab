require 'test_helper'

class Manage::AdminTest < ActiveSupport::TestCase

  test "管理员属性不能为空" do
    admin=Manage::Admin.new
    assert admin.invalid?
    assert admin.errors[:uid].any?,admin.errors[:uid]
    assert admin.errors[:nickname].any?,admin.errors[:nickname]
  end

  test "email格式" do
    ok = %w{ 142064699@qq.com fr_1ed@gmail.com fred@sina.com FRED@163.com 
           		ABC13a@123.com abcdf@QQ.COM}
    bad = %w{ 142ABC@A abcdef fred@qq_com 1313*~&abc@qq.com}
  
    admin = Manage::Admin.new(:uid        => "admin",
                              :nickname   => "管理员",
                              :is_enabled => 1,
                              :desc       => "管理员",
                              :password   =>"123abc123")
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
