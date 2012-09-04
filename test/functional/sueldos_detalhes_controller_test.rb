require 'test_helper'

class SueldosDetalhesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sueldos_detalhes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sueldos_detalhe" do
    assert_difference('SueldosDetalhe.count') do
      post :create, :sueldos_detalhe => { }
    end

    assert_redirected_to sueldos_detalhe_path(assigns(:sueldos_detalhe))
  end

  test "should show sueldos_detalhe" do
    get :show, :id => sueldos_detalhes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sueldos_detalhes(:one).to_param
    assert_response :success
  end

  test "should update sueldos_detalhe" do
    put :update, :id => sueldos_detalhes(:one).to_param, :sueldos_detalhe => { }
    assert_redirected_to sueldos_detalhe_path(assigns(:sueldos_detalhe))
  end

  test "should destroy sueldos_detalhe" do
    assert_difference('SueldosDetalhe.count', -1) do
      delete :destroy, :id => sueldos_detalhes(:one).to_param
    end

    assert_redirected_to sueldos_detalhes_path
  end
end
