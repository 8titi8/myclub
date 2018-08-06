require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
include SessionsHelper  

  def setup
    @user = users(:one)
  end

  test "should get home" do
    get root_url
    assert_response :success
    if logged_in?
      assert_select "a[href=?]", '/users/:id/edit', text: "Editer mon profil"
      assert_select "a[href=?]", '/logout', text: "Se déconnecter"
    else
      assert_select "a[href=?]", '/login', text: "Se connecter" 
      assert_select "a[href=?]", '/users/new', text: "S'inscrire" 
    end
  end

end
