require 'test_helper'

class TransferenciaContasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transferencia_contas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transferencia_conta" do
    assert_difference('TransferenciaConta.count') do
      post :create, :transferencia_conta => { }
    end

    assert_redirected_to transferencia_conta_path(assigns(:transferencia_conta))
  end

  test "should show transferencia_conta" do
    get :show, :id => transferencia_contas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => transferencia_contas(:one).to_param
    assert_response :success
  end

  test "should update transferencia_conta" do
    put :update, :id => transferencia_contas(:one).to_param, :transferencia_conta => { }
    assert_redirected_to transferencia_conta_path(assigns(:transferencia_conta))
  end

  test "should destroy transferencia_conta" do
    assert_difference('TransferenciaConta.count', -1) do
      delete :destroy, :id => transferencia_contas(:one).to_param
    end

    assert_redirected_to transferencia_contas_path
  end
end
