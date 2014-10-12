require 'test_helper'

class Manage::StudentsControllerTest < ActionController::TestCase
  setup do
    @manage_student = manage_students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manage_students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manage_student" do
    assert_difference('Manage::Student.count') do
      post :create, manage_student: { email: @manage_student.email, grade: @manage_student.grade, name: @manage_student.name, phone: @manage_student.phone, stuid: @manage_student.stuid }
    end

    assert_redirected_to manage_student_path(assigns(:manage_student))
  end

  test "should show manage_student" do
    get :show, id: @manage_student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manage_student
    assert_response :success
  end

  test "should update manage_student" do
    patch :update, id: @manage_student, manage_student: { email: @manage_student.email, grade: @manage_student.grade, name: @manage_student.name, phone: @manage_student.phone, stuid: @manage_student.stuid }
    assert_redirected_to manage_student_path(assigns(:manage_student))
  end

  test "should destroy manage_student" do
    assert_difference('Manage::Student.count', -1) do
      delete :destroy, id: @manage_student
    end

    assert_redirected_to manage_students_path
  end
end
