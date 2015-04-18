require 'test_helper'

class Index::NewsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get summary" do
    get :summary
    assert_response :success
  end

end
