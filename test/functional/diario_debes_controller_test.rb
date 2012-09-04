require 'test_helper'

class DiarioDebesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:diario_debes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create diario_debe" do
    assert_difference('DiarioDebe.count') do
      post :create, :diario_debe => { }
    end

    assert_redirected_to diario_debe_path(assigns(:diario_debe))
  end

  test "should show diario_debe" do
    get :show, :id => diario_debes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => diario_debes(:one).to_param
    assert_response :success
  end

  test "should update diario_debe" do
    put :update, :id => diario_debes(:one).to_param, :diario_debe => { }
    assert_redirected_to diario_debe_path(assigns(:diario_debe))
  end

  test "should destroy diario_debe" do
    assert_difference('DiarioDebe.count', -1) do
      delete :destroy, :id => diario_debes(:one).to_param
    end

    assert_redirected_to diario_debes_path
  end
end
