require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get professions" do
    get :professions
    assert_response :success
  end

end
