require 'test_helper'

class KiberaChildrenControllerTest < ActionController::TestCase
  setup do
    @kibera_child = kibera_children(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kibera_children)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kibera_child" do
    assert_difference('KiberaChild.count') do
      post :create, :kibera_child => @kibera_child.attributes
    end

    assert_redirected_to kibera_child_path(assigns(:kibera_child))
  end

  test "should show kibera_child" do
    get :show, :id => @kibera_child.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @kibera_child.to_param
    assert_response :success
  end

  test "should update kibera_child" do
    put :update, :id => @kibera_child.to_param, :kibera_child => @kibera_child.attributes
    assert_redirected_to kibera_child_path(assigns(:kibera_child))
  end

  test "should destroy kibera_child" do
    assert_difference('KiberaChild.count', -1) do
      delete :destroy, :id => @kibera_child.to_param
    end

    assert_redirected_to kibera_children_path
  end
end
