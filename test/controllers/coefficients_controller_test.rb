require 'test_helper'

class CoefficientsControllerTest < ActionController::TestCase
  setup do
    @coefficient = coefficients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coefficients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coefficient" do
    assert_difference('Coefficient.count') do
      post :create, coefficient: {  }
    end

    assert_redirected_to coefficient_path(assigns(:coefficient))
  end

  test "should show coefficient" do
    get :show, id: @coefficient
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coefficient
    assert_response :success
  end

  test "should update coefficient" do
    patch :update, id: @coefficient, coefficient: {  }
    assert_redirected_to coefficient_path(assigns(:coefficient))
  end

  test "should destroy coefficient" do
    assert_difference('Coefficient.count', -1) do
      delete :destroy, id: @coefficient
    end

    assert_redirected_to coefficients_path
  end
end
