require 'test_helper'

class ProductTemplatesControllerTest < ActionController::TestCase
  setup do
    @product_template = product_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_template" do
    assert_difference('ProductTemplate.count') do
      post :create, product_template: {  }
    end

    assert_redirected_to product_template_path(assigns(:product_template))
  end

  test "should show product_template" do
    get :show, id: @product_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_template
    assert_response :success
  end

  test "should update product_template" do
    patch :update, id: @product_template, product_template: {  }
    assert_redirected_to product_template_path(assigns(:product_template))
  end

  test "should destroy product_template" do
    assert_difference('ProductTemplate.count', -1) do
      delete :destroy, id: @product_template
    end

    assert_redirected_to product_templates_path
  end
end
