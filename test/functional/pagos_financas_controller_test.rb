require 'test_helper'

class PagosFinancasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pagos_financas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pagos_financa" do
    assert_difference('PagosFinanca.count') do
      post :create, :pagos_financa => { }
    end

    assert_redirected_to pagos_financa_path(assigns(:pagos_financa))
  end

  test "should show pagos_financa" do
    get :show, :id => pagos_financas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pagos_financas(:one).to_param
    assert_response :success
  end

  test "should update pagos_financa" do
    put :update, :id => pagos_financas(:one).to_param, :pagos_financa => { }
    assert_redirected_to pagos_financa_path(assigns(:pagos_financa))
  end

  test "should destroy pagos_financa" do
    assert_difference('PagosFinanca.count', -1) do
      delete :destroy, :id => pagos_financas(:one).to_param
    end

    assert_redirected_to pagos_financas_path
  end
end
