require 'test_helper'

class Cxpt::MnewsControllerTest < ActionController::TestCase
  setup do
    @cxpt_mnews = cxpt_mnews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cxpt_mnews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cxpt_mnews" do
    assert_difference('Cxpt::Mnews.count') do
      post :create, cxpt_mnews: { author: @cxpt_mnews.author, content: @cxpt_mnews.content, cxcate_id: @cxpt_mnews.cxcate_id, publish_at: @cxpt_mnews.publish_at, summary: @cxpt_mnews.summary, title: @cxpt_mnews.title, view_count: @cxpt_mnews.view_count }
    end

    assert_redirected_to cxpt_mnews_path(assigns(:cxpt_mnews))
  end

  test "should show cxpt_mnews" do
    get :show, id: @cxpt_mnews
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cxpt_mnews
    assert_response :success
  end

  test "should update cxpt_mnews" do
    patch :update, id: @cxpt_mnews, cxpt_mnews: { author: @cxpt_mnews.author, content: @cxpt_mnews.content, cxcate_id: @cxpt_mnews.cxcate_id, publish_at: @cxpt_mnews.publish_at, summary: @cxpt_mnews.summary, title: @cxpt_mnews.title, view_count: @cxpt_mnews.view_count }
    assert_redirected_to cxpt_mnews_path(assigns(:cxpt_mnews))
  end

  test "should destroy cxpt_mnews" do
    assert_difference('Cxpt::Mnews.count', -1) do
      delete :destroy, id: @cxpt_mnews
    end

    assert_redirected_to cxpt_mnews_index_path
  end
end
