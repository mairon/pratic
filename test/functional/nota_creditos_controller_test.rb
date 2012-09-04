require 'test_helper'

class NotaCreditosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nota_creditos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nota_credito" do
    assert_difference('NotaCredito.count') do
      post :create, :nota_credito => { }
    end

    assert_redirected_to nota_credito_path(assigns(:nota_credito))
  end

  test "should show nota_credito" do
    get :show, :id => nota_creditos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => nota_creditos(:one).to_param
    assert_response :success
  end

  test "should update nota_credito" do
    put :update, :id => nota_creditos(:one).to_param, :nota_credito => { }
    assert_redirected_to nota_credito_path(assigns(:nota_credito))
  end

  test "should destroy nota_credito" do
    assert_difference('NotaCredito.count', -1) do
      delete :destroy, :id => nota_creditos(:one).to_param
    end

    assert_redirected_to nota_creditos_path
  end
end
