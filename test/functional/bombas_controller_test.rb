require 'test_helper'

class BombasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bombas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bomba" do
    assert_difference('Bomba.count') do
      post :create, :bomba => { }
    end

    assert_redirected_to bomba_path(assigns(:bomba))
  end

  test "should show bomba" do
    get :show, :id => bombas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bombas(:one).to_param
    assert_response :success
  end

  test "should update bomba" do
    put :update, :id => bombas(:one).to_param, :bomba => { }
    assert_redirected_to bomba_path(assigns(:bomba))
  end

  test "should destroy bomba" do
    assert_difference('Bomba.count', -1) do
      delete :destroy, :id => bombas(:one).to_param
    end

    assert_redirected_to bombas_path
  end
end
