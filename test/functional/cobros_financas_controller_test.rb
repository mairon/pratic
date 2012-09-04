require 'test_helper'

class CobrosFinancasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cobros_financas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cobros_financa" do
    assert_difference('CobrosFinanca.count') do
      post :create, :cobros_financa => { }
    end

    assert_redirected_to cobros_financa_path(assigns(:cobros_financa))
  end

  test "should show cobros_financa" do
    get :show, :id => cobros_financas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cobros_financas(:one).to_param
    assert_response :success
  end

  test "should update cobros_financa" do
    put :update, :id => cobros_financas(:one).to_param, :cobros_financa => { }
    assert_redirected_to cobros_financa_path(assigns(:cobros_financa))
  end

  test "should destroy cobros_financa" do
    assert_difference('CobrosFinanca.count', -1) do
      delete :destroy, :id => cobros_financas(:one).to_param
    end

    assert_redirected_to cobros_financas_path
  end
end
