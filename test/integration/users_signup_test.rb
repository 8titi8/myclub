require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
      @user = users(:one)
  end

  test "invalid signup information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name:  "",
                                         last_name: "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div', attributes: {id: "error_explanation"}
    assert_select 'div.alert-danger'
  end


  test "valid signup information" do
    get new_user_path
    nb_before = User.count
    post users_path, params: { user: { first_name:  "test",
                                       last_name: "test",
                                       email: "user@invalid.fr",
                                       password:              "foofoo",
                                       password_confirmation: "foofoo" } }
    nb_after = User.count

    assert (nb_before +1 ) == nb_after

  end


end
