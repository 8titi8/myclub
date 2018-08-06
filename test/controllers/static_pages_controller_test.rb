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
      assert_select "a[href=?]", '/', text: "foo" 
    else
      assert_select "a[href=?]", '/', text: "foo" 
      assert_select "a[href=?]", '/', text: "foo" 
    end
  end

end
