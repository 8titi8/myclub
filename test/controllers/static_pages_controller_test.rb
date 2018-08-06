require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "should display navbar selectors if user logged" do
    log_in_as(@user)
    get root_url
    assert_response :success
    assert_select "a[href=?]", user_path(@user.id), text: "Mon profil"
    assert_select "a[href=?]", logout_path        , text: "Me déconnecter"
    assert_select "a[href=?]", users_path         , text: "Page privée"
  end

  test "should display navbar selectors if user not logged" do
    log_out_user
    get root_url
    assert_response :success
    assert_select "a[href=?]", login_path   , text: "Se connecter"
    assert_select "a[href=?]", new_user_path, text: "S'inscrire"
  end

  test "should display body links if user logged" do
    log_in_as(@user)
    get root_url
    assert_response :success
    assert_select 'p' do
      assert_select "a[href=?]", users_path, text: "Accédez ici à votre espace privé."
    end
  end

  test "should display body links if user not logged" do
    log_out_user
    get root_url
    assert_response :success
    assert_select 'p' do
      assert_select "a[href=?]", login_path   , text: "Connectez-vous"
      assert_select "a[href=?]", new_user_path, text: "inscrivez-vous"
    end
  end

end
