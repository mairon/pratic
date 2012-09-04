require 'test_helper'

class DiariosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:diarios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create diario" do
    assert_difference('Diario.count') do
      post :create, :diario => { }
    end

    assert_redirected_to diario_path(assigns(:diario))
  end

  test "should show diario" do
    get :show, :id => diarios(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => diarios(:one).to_param
    assert_response :success
  end

  test "should update diario" do
    put :update, :id => diarios(:one).to_param, :diario => { }
    assert_redirected_to diario_path(assigns(:diario))
  end

  test "should destroy diario" do
    assert_difference('Diario.count', -1) do
      delete :destroy, :id => diarios(:one).to_param
    end

    assert_redirected_to diarios_path
  end
end
