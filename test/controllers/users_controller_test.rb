require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    post users_url, params: { user: { email: "test@example.com", password: "password" } }
    assert_response :redirect
  end

  test "should show user" do
    user = users(:one)
    get user_url(user)
    assert_response :success
  end
end
