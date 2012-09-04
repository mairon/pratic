require 'test_helper'

class SobrantesFaltantesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sobrantes_faltantes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sobrantes_faltante" do
    assert_difference('SobrantesFaltante.count') do
      post :create, :sobrantes_faltante => { }
    end

    assert_redirected_to sobrantes_faltante_path(assigns(:sobrantes_faltante))
  end

  test "should show sobrantes_faltante" do
    get :show, :id => sobrantes_faltantes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sobrantes_faltantes(:one).to_param
    assert_response :success
  end

  test "should update sobrantes_faltante" do
    put :update, :id => sobrantes_faltantes(:one).to_param, :sobrantes_faltante => { }
    assert_redirected_to sobrantes_faltante_path(assigns(:sobrantes_faltante))
  end

  test "should destroy sobrantes_faltante" do
    assert_difference('SobrantesFaltante.count', -1) do
      delete :destroy, :id => sobrantes_faltantes(:one).to_param
    end

    assert_redirected_to sobrantes_faltantes_path
  end
end
