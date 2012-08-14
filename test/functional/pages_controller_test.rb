require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get resources" do
    get :resources
    assert_response :success
  end

  test "should get contact_us" do
    get :contact_us
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

end
