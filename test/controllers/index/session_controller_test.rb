require 'test_helper'

class Index::SessionControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

end
