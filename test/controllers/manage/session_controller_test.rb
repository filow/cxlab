require 'test_helper'

class Manage::SessionControllerTest < ActionController::TestCase
  test "访问登录页面" do
    get :index
    assert_response :success
  end

  test "用户登录" do
  	admin = manage_admins(:admin_one)
	post :create,  {name: admin.uid,password: '123456789'}
 	
  	assert_redirected_to manage_index_index_url
    
  end
  test "退出登录" do
    delete :logout
  	assert_redirected_to manage_login_url
  end

end
