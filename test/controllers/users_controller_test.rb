require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include SessionsHelper  

  def setup
    @user = users(:one)
    @other_user = users(:two)
  end


  test "should access to private" do
    if log_in_as(@user)
      get index_url
      assert_response :success

    else
      get login_url
      assert_response :success
    end
  end

end

