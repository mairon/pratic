require 'test_helper'

class DiarioHabersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:diario_habers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create diario_haber" do
    assert_difference('DiarioHaber.count') do
      post :create, :diario_haber => { }
    end

    assert_redirected_to diario_haber_path(assigns(:diario_haber))
  end

  test "should show diario_haber" do
    get :show, :id => diario_habers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => diario_habers(:one).to_param
    assert_response :success
  end

  test "should update diario_haber" do
    put :update, :id => diario_habers(:one).to_param, :diario_haber => { }
    assert_redirected_to diario_haber_path(assigns(:diario_haber))
  end

  test "should destroy diario_haber" do
    assert_difference('DiarioHaber.count', -1) do
      delete :destroy, :id => diario_habers(:one).to_param
    end

    assert_redirected_to diario_habers_path
  end
end
