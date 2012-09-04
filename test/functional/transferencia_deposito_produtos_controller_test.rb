require 'test_helper'

class TransferenciaDepositoProdutosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transferencia_deposito_produtos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transferencia_deposito_produto" do
    assert_difference('TransferenciaDepositoProduto.count') do
      post :create, :transferencia_deposito_produto => { }
    end

    assert_redirected_to transferencia_deposito_produto_path(assigns(:transferencia_deposito_produto))
  end

  test "should show transferencia_deposito_produto" do
    get :show, :id => transferencia_deposito_produtos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => transferencia_deposito_produtos(:one).to_param
    assert_response :success
  end

  test "should update transferencia_deposito_produto" do
    put :update, :id => transferencia_deposito_produtos(:one).to_param, :transferencia_deposito_produto => { }
    assert_redirected_to transferencia_deposito_produto_path(assigns(:transferencia_deposito_produto))
  end

  test "should destroy transferencia_deposito_produto" do
    assert_difference('TransferenciaDepositoProduto.count', -1) do
      delete :destroy, :id => transferencia_deposito_produtos(:one).to_param
    end

    assert_redirected_to transferencia_deposito_produtos_path
  end
end
