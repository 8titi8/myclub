require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
 def setup
    @user = users(:one)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "",
    										   last_name: "garcia",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end
end
