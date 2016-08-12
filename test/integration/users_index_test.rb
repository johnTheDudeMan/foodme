require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:baci)
    @non_admin_user = users(:hotdog)
  end

  test "index as non-admin user with pagination" do
    log_in_as @non_admin_user
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    assert_select '.avatar-index'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      assert_select 'a', text: 'delete', count: 0
    end
  end

  test "index as admin should show delete and should destroy user" do
    log_in_as @admin
    get users_path
    User.paginate(page: 1).each do |user|
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin_user)
    end
  end
end
