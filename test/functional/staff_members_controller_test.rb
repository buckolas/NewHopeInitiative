require 'test_helper'

class StaffMembersControllerTest < ActionController::TestCase
  setup do
    @staff_member = staff_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staff_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff_member" do
    assert_difference('StaffMember.count') do
      post :create, :staff_member => @staff_member.attributes
    end

    assert_redirected_to staff_member_path(assigns(:staff_member))
  end

  test "should show staff_member" do
    get :show, :id => @staff_member.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @staff_member.to_param
    assert_response :success
  end

  test "should update staff_member" do
    put :update, :id => @staff_member.to_param, :staff_member => @staff_member.attributes
    assert_redirected_to staff_member_path(assigns(:staff_member))
  end

  test "should destroy staff_member" do
    assert_difference('StaffMember.count', -1) do
      delete :destroy, :id => @staff_member.to_param
    end

    assert_redirected_to staff_members_path
  end
end
