require 'test_helper'

class Manage::NodesControllerTest < ActionController::TestCase
  setup do
    @manage_node = manage_nodes(:node_admin)
  end

  test "[登录状态]可以访问权限管理页面" do
    admin_login
    get :index
    assert_response :success
    assert_not_nil assigns(:manage_nodes)
  end

  test "[未登录状态]不能访问权限管理页面" do
    admin_logout
    get :index
    assert_redirected_to manage_login_path
  end

end
