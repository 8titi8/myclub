require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include SessionsHelper  

  def setup
    @user = users(:one)
  end


  test "should access to private" do
    log_in_as(@user)
    get index_url
    assert_response :success
  end

end

