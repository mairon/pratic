require 'test_helper'

class FechamentoTurnosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fechamento_turnos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fechamento_turno" do
    assert_difference('FechamentoTurno.count') do
      post :create, :fechamento_turno => { }
    end

    assert_redirected_to fechamento_turno_path(assigns(:fechamento_turno))
  end

  test "should show fechamento_turno" do
    get :show, :id => fechamento_turnos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => fechamento_turnos(:one).to_param
    assert_response :success
  end

  test "should update fechamento_turno" do
    put :update, :id => fechamento_turnos(:one).to_param, :fechamento_turno => { }
    assert_redirected_to fechamento_turno_path(assigns(:fechamento_turno))
  end

  test "should destroy fechamento_turno" do
    assert_difference('FechamentoTurno.count', -1) do
      delete :destroy, :id => fechamento_turnos(:one).to_param
    end

    assert_redirected_to fechamento_turnos_path
  end
end
