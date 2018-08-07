require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
 def setup
   @user = users(:one)
   @user2 = users(:two)
  end

  test "unsuccessful show" do
    user = User.first
    get user_path user.id
    assert_redirected_to login_path
  end


  test "successful show" do
    log_in_as(@user)
    get user_path @user.id
    assert_template 'show'
  end

  test "show in navbar " do
    log_in_as(@user)
    user =  User.first
    get root_url
    assert_response :success
    assert_select "a[href=?]", user_path(@user.id), text: "Mon profil"
  end


  test "successful show data" do
    log_in_as(@user)
    get user_path @user.id
    assert_template 'show'
    assert_select "div[id=prenom]" , text: @user.first_name
    assert_select "div[id=nom]" , text: @user.last_name
    assert_select "div[id=email]" , text: @user.email
  end

  test "unsuccessful show data (not the current user)" do
    log_in_as(@user)
    user2 = User.find_by(email: @user2.email)
    get user_path user2.id
    assert_redirected_to root_path
  end








end
