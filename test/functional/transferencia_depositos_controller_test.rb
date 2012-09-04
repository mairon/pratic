require 'test_helper'

class TransferenciaDepositosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transferencia_depositos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transferencia_deposito" do
    assert_difference('TransferenciaDeposito.count') do
      post :create, :transferencia_deposito => { }
    end

    assert_redirected_to transferencia_deposito_path(assigns(:transferencia_deposito))
  end

  test "should show transferencia_deposito" do
    get :show, :id => transferencia_depositos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => transferencia_depositos(:one).to_param
    assert_response :success
  end

  test "should update transferencia_deposito" do
    put :update, :id => transferencia_depositos(:one).to_param, :transferencia_deposito => { }
    assert_redirected_to transferencia_deposito_path(assigns(:transferencia_deposito))
  end

  test "should destroy transferencia_deposito" do
    assert_difference('TransferenciaDeposito.count', -1) do
      delete :destroy, :id => transferencia_depositos(:one).to_param
    end

    assert_redirected_to transferencia_depositos_path
  end
end
