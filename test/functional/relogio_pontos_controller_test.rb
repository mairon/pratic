require 'test_helper'

class RelogioPontosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:relogio_pontos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create relogio_ponto" do
    assert_difference('RelogioPonto.count') do
      post :create, :relogio_ponto => { }
    end

    assert_redirected_to relogio_ponto_path(assigns(:relogio_ponto))
  end

  test "should show relogio_ponto" do
    get :show, :id => relogio_pontos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => relogio_pontos(:one).to_param
    assert_response :success
  end

  test "should update relogio_ponto" do
    put :update, :id => relogio_pontos(:one).to_param, :relogio_ponto => { }
    assert_redirected_to relogio_ponto_path(assigns(:relogio_ponto))
  end

  test "should destroy relogio_ponto" do
    assert_difference('RelogioPonto.count', -1) do
      delete :destroy, :id => relogio_pontos(:one).to_param
    end

    assert_redirected_to relogio_pontos_path
  end
end
