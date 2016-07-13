require 'test_helper'

class UsersEditTestTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:baci)
  end

  test "unsuccessful user edit" do
  	log_in_as @user
    get edit_user_path @user
    assert_template 'users/edit'
    patch user_path @user, params: { user: { name: "", email: "not@valid.email",
    																				 password: "foo", password_confirmation: "bar" }}
    assert_template 'users/edit'
    assert_select "div.alert-danger"
  end

  test "successful user edit" do
    log_in_as @user
    name = "cat name"
    email = "purrr@foodme.com"
    patch user_path @user, params: { user: { name: name, email: email }}
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
    assert_redirected_to @user_url
    follow_redirect!
    assert_select "div.alert-success"
  end

end
