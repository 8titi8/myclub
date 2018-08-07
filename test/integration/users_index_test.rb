require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "unsuccessful index" do
    get index_path
    assert_redirected_to login_path
    assert_not flash.empty?
  end

  test "successful index" do
    log_in_as(@user)
    get index_path
    assert_template 'index'

  end

  test "successful index data" do
    log_in_as(@user)
    get index_path
    assert_template 'index'
    assert_select "tr", count: (User.count) + 1  # +1 car  un tr utilisé pour la legende
  end

end
