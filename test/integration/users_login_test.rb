require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:baci)
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

	test "login with valid information" do
	  get login_path
	  log_in_as @user
	  assert_redirected_to root_url
	  follow_redirect!
	end
end
