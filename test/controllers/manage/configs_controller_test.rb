require 'test_helper'

class Manage::ConfigsControllerTest < ActionController::TestCase
  setup do
    @manage_config = manage_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manage_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manage_config" do
    assert_difference('Manage::Config.count') do
      post :create, manage_config: { field_type: @manage_config.field_type, key: @manage_config.key, value: @manage_config.value }
    end

    assert_redirected_to manage_config_path(assigns(:manage_config))
  end

  test "should show manage_config" do
    get :show, id: @manage_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manage_config
    assert_response :success
  end

  test "should update manage_config" do
    patch :update, id: @manage_config, manage_config: { field_type: @manage_config.field_type, key: @manage_config.key, value: @manage_config.value }
    assert_redirected_to manage_config_path(assigns(:manage_config))
  end

  test "should destroy manage_config" do
    assert_difference('Manage::Config.count', -1) do
      delete :destroy, id: @manage_config
    end

    assert_redirected_to manage_configs_path
  end
end
