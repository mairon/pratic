require 'test_helper'

class NotaCreditosDetalhesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nota_creditos_detalhes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nota_creditos_detalhe" do
    assert_difference('NotaCreditosDetalhe.count') do
      post :create, :nota_creditos_detalhe => { }
    end

    assert_redirected_to nota_creditos_detalhe_path(assigns(:nota_creditos_detalhe))
  end

  test "should show nota_creditos_detalhe" do
    get :show, :id => nota_creditos_detalhes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => nota_creditos_detalhes(:one).to_param
    assert_response :success
  end

  test "should update nota_creditos_detalhe" do
    put :update, :id => nota_creditos_detalhes(:one).to_param, :nota_creditos_detalhe => { }
    assert_redirected_to nota_creditos_detalhe_path(assigns(:nota_creditos_detalhe))
  end

  test "should destroy nota_creditos_detalhe" do
    assert_difference('NotaCreditosDetalhe.count', -1) do
      delete :destroy, :id => nota_creditos_detalhes(:one).to_param
    end

    assert_redirected_to nota_creditos_detalhes_path
  end
end
