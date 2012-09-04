require 'test_helper'

class ProducaoProdutosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:producao_produtos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create producao_produto" do
    assert_difference('ProducaoProduto.count') do
      post :create, :producao_produto => { }
    end

    assert_redirected_to producao_produto_path(assigns(:producao_produto))
  end

  test "should show producao_produto" do
    get :show, :id => producao_produtos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => producao_produtos(:one).to_param
    assert_response :success
  end

  test "should update producao_produto" do
    put :update, :id => producao_produtos(:one).to_param, :producao_produto => { }
    assert_redirected_to producao_produto_path(assigns(:producao_produto))
  end

  test "should destroy producao_produto" do
    assert_difference('ProducaoProduto.count', -1) do
      delete :destroy, :id => producao_produtos(:one).to_param
    end

    assert_redirected_to producao_produtos_path
  end
end
