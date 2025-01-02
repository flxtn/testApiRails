require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get UsersController" do
    get users_UsersController_url
    assert_response :success
  end
end
