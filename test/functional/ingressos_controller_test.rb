require 'test_helper'

class IngressosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingressos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ingresso" do
    assert_difference('Ingresso.count') do
      post :create, :ingresso => { }
    end

    assert_redirected_to ingresso_path(assigns(:ingresso))
  end

  test "should show ingresso" do
    get :show, :id => ingressos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ingressos(:one).to_param
    assert_response :success
  end

  test "should update ingresso" do
    put :update, :id => ingressos(:one).to_param, :ingresso => { }
    assert_redirected_to ingresso_path(assigns(:ingresso))
  end

  test "should destroy ingresso" do
    assert_difference('Ingresso.count', -1) do
      delete :destroy, :id => ingressos(:one).to_param
    end

    assert_redirected_to ingressos_path
  end
end
