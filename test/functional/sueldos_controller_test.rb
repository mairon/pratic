require 'test_helper'

class SueldosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sueldos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sueldo" do
    assert_difference('Sueldo.count') do
      post :create, :sueldo => { }
    end

    assert_redirected_to sueldo_path(assigns(:sueldo))
  end

  test "should show sueldo" do
    get :show, :id => sueldos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sueldos(:one).to_param
    assert_response :success
  end

  test "should update sueldo" do
    put :update, :id => sueldos(:one).to_param, :sueldo => { }
    assert_redirected_to sueldo_path(assigns(:sueldo))
  end

  test "should destroy sueldo" do
    assert_difference('Sueldo.count', -1) do
      delete :destroy, :id => sueldos(:one).to_param
    end

    assert_redirected_to sueldos_path
  end
end
