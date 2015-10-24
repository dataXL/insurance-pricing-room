require 'test_helper'

class CodingsControllerTest < ActionController::TestCase
  setup do
    @coding = codings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:codings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coding" do
    assert_difference('Coding.count') do
      post :create, coding: {  }
    end

    assert_redirected_to coding_path(assigns(:coding))
  end

  test "should show coding" do
    get :show, id: @coding
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coding
    assert_response :success
  end

  test "should update coding" do
    patch :update, id: @coding, coding: {  }
    assert_redirected_to coding_path(assigns(:coding))
  end

  test "should destroy coding" do
    assert_difference('Coding.count', -1) do
      delete :destroy, id: @coding
    end

    assert_redirected_to codings_path
  end
end
