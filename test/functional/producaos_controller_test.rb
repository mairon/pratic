require 'test_helper'

class ProducaosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:producaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create producao" do
    assert_difference('Producao.count') do
      post :create, :producao => { }
    end

    assert_redirected_to producao_path(assigns(:producao))
  end

  test "should show producao" do
    get :show, :id => producaos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => producaos(:one).to_param
    assert_response :success
  end

  test "should update producao" do
    put :update, :id => producaos(:one).to_param, :producao => { }
    assert_redirected_to producao_path(assigns(:producao))
  end

  test "should destroy producao" do
    assert_difference('Producao.count', -1) do
      delete :destroy, :id => producaos(:one).to_param
    end

    assert_redirected_to producaos_path
  end
end
