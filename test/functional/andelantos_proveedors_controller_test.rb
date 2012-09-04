require 'test_helper'

class AndelantosProveedorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:andelantos_proveedors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create andelantos_proveedor" do
    assert_difference('AndelantosProveedor.count') do
      post :create, :andelantos_proveedor => { }
    end

    assert_redirected_to andelantos_proveedor_path(assigns(:andelantos_proveedor))
  end

  test "should show andelantos_proveedor" do
    get :show, :id => andelantos_proveedors(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => andelantos_proveedors(:one).to_param
    assert_response :success
  end

  test "should update andelantos_proveedor" do
    put :update, :id => andelantos_proveedors(:one).to_param, :andelantos_proveedor => { }
    assert_redirected_to andelantos_proveedor_path(assigns(:andelantos_proveedor))
  end

  test "should destroy andelantos_proveedor" do
    assert_difference('AndelantosProveedor.count', -1) do
      delete :destroy, :id => andelantos_proveedors(:one).to_param
    end

    assert_redirected_to andelantos_proveedors_path
  end
end
