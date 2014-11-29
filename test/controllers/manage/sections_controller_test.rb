require 'test_helper'

class Manage::SectionsControllerTest < ActionController::TestCase
  setup do
    @manage_section = manage_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manage_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manage_section" do
    assert_difference('Manage::Section.count') do
      post :create, manage_section: { end_time: @manage_section.end_time, name: @manage_section.name, start_time: @manage_section.start_time }
    end

    assert_redirected_to manage_section_path(assigns(:manage_section))
  end

  test "should show manage_section" do
    get :show, id: @manage_section
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manage_section
    assert_response :success
  end

  test "should update manage_section" do
    patch :update, id: @manage_section, manage_section: { end_time: @manage_section.end_time, name: @manage_section.name, start_time: @manage_section.start_time }
    assert_redirected_to manage_section_path(assigns(:manage_section))
  end

  test "should destroy manage_section" do
    assert_difference('Manage::Section.count', -1) do
      delete :destroy, id: @manage_section
    end

    assert_redirected_to manage_sections_path
  end
end
