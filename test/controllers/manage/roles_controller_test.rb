require 'test_helper'

class Manage::RolesControllerTest < ActionController::TestCase
  setup do
    @manage_role = manage_roles(:one)
    admin_login
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manage_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manage_role" do
    assert_difference('Manage::Role.count') do
      post :create, manage_role: { is_enabled: @manage_role.is_enabled, name: @manage_role.name, remark: @manage_role.remark }
    end

    assert_redirected_to manage_role_path(assigns(:manage_role))
  end

  test "should show manage_role" do
    get :show, id: @manage_role
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manage_role
    assert_response :success
  end

  test "should update manage_role" do
    patch :update, id: @manage_role, manage_role: { is_enabled: @manage_role.is_enabled, name: @manage_role.name, remark: @manage_role.remark }
    assert_redirected_to manage_role_path(assigns(:manage_role))
  end

  test "should destroy manage_role" do
    assert_difference('Manage::Role.count', -1) do
      delete :destroy, id: @manage_role
    end

    assert_redirected_to manage_roles_path
  end
end
