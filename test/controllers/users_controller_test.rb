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

  test "should access users infos if logged" do
    if log_in_as(@user)
    get user_path(@user.id)
    assert_response :success

  else
    assert_template 'sessions/new'
    assert_not flash.empty?
       get root_path
       assert flash.empty?    
  end




  end

end
