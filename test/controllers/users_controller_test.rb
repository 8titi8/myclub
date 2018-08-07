require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include SessionsHelper

  def setup
    @user = users(:one)
    @other_user = users(:two)
  end


  test "should access to private  if logged" do

    get login_path
    assert_template 'sessions/new'
    log_in_as @user
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

  end

  test "should access users infos if logged" do
    log_in_as(@user)
    get user_path(@user.id)
    assert_response :success
  end

  test "should not access user infos if logged" do
    get user_path(@user.id)
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should show users infos if logged" do
    log_in_as(@user)
    get users_path
    assert_response :success
    assert_select "tr", count: (User.count) + 1  # +1 car  un tr utilisé pour la legende

  end


end
