require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:baci)
		@non_activated_user = users(:hotdog)
	end

	test "login with invalid information" do
	  get login_path
	  assert_template 'sessions/new'
	  post login_path, session: { email: "invalid@nope.com", password: "invalid" }
	  assert_template 'sessions/new'
	  assert_not flash.empty?
	  get root_path
	  assert flash.empty?
	end

	test "login without activation" do
	  get login_path
	  log_in_as @non_activated_user
	  assert_redirected_to root_url
	  follow_redirect!
	  assert_not flash.empty?
	  assert_select 'div.alert-warning'
	  assert_select 'div.jumbotron'
	  assert_not is_logged_in?
	end

	test "login with valid information then logout" do
	  get login_path
	  assert_select "#session_remember_me" do
	  	assert_select "[value=?]", "1"
	  end
	  log_in_as @user
	  assert_redirected_to root_url
	  follow_redirect!
	  assert_template 'static_pages/home'
	  assert is_logged_in?
	  assert_select "a[href=?]", login_path, count: 0
	  assert_select "a[href=?]", logout_path
	  assert_select "a[href=?]", user_path(@user)
	  assert_select "a[href=?]", edit_user_path(@user)
	  delete logout_path
	  assert_redirected_to root_url
	  follow_redirect!
	  assert_select "a[href=?]", login_path
	  assert_select "a[href=?]", logout_path, count: 0
	  assert_not is_logged_in?
	  # Logout from 2nd browser
	  delete logout_path
	  assert_redirected_to root_url
	  follow_redirect!
	  assert_select "a[href=?]", login_path
	end

	test "log in with remember me" do
		# default in test helper is remember_me = '1'
	  log_in_as(@user)
	  assert_not_nil cookies['remember_token']
	end

	test "log in without remember me" do
	  log_in_as(@user, remember_me: '0')
	  assert_nil cookies['remember_token']
	end

end
