require 'test_helper'

class ProventosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proventos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create provento" do
    assert_difference('Provento.count') do
      post :create, :provento => { }
    end

    assert_redirected_to provento_path(assigns(:provento))
  end

  test "should show provento" do
    get :show, :id => proventos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => proventos(:one).to_param
    assert_response :success
  end

  test "should update provento" do
    put :update, :id => proventos(:one).to_param, :provento => { }
    assert_redirected_to provento_path(assigns(:provento))
  end

  test "should destroy provento" do
    assert_difference('Provento.count', -1) do
      delete :destroy, :id => proventos(:one).to_param
    end

    assert_redirected_to proventos_path
  end
end
