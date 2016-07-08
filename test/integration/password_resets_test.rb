require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

	def setup
		ActionMailer::Base.deliveries.clear
		@user = users(:baci)
	end

	test "valid password reset flow" do
	  get login_path
	  assert_select "a[href=?]", new_password_reset_path
	  get new_password_reset_path
	  assert_template 'password_resets/new'
	  assert_select 'title', "Forgot password? | FOODme"
	  post password_resets_path password_reset: { email: @user.email }
	  assert_not_equal @user.pw_reset_digest, @user.reload.pw_reset_digest
	  assert_equal 1, ActionMailer::Base.deliveries.size
	  assert_not flash.empty?
	  assert_redirected_to root_url
	  user = assigns(:user)
	  get edit_password_reset_path(user.pw_reset_token, email: user.email)
	  assert_template 'password_resets/edit'
	  assert_select "input[name=email][type=hidden][value=?]", user.email
	  patch password_reset_path(user.pw_reset_token), email: user.email, 
	  			user: { password: "foobar", password_confirmation: "foobar" }
	  assert is_logged_in?
	  assert_not flash.empty?
	  assert_redirected_to user
	  follow_redirect!
	  assert_select "div.alert-success"
	end

	test "password reset submition with non-existent email" do
	  post password_resets_path password_reset: { email: "does@not.exist" }
	  assert_not flash.empty?
	  assert_template 'password_resets/new'
	end

	test "password reset with invalid token/email" do
	  post password_resets_path password_reset: { email: @user.email }
	  user = assigns(:user)
	  # wrong token correct email
	  get edit_password_reset_path("wrongToken", email: user.email)
	  assert_redirected_to root_url
	  assert_not flash.empty?
	  # Correct token wrong email
	  get edit_password_reset_path(user.pw_reset_token, email: "not@correct.email")
	  assert_redirected_to root_url
	  follow_redirect!
	  assert_select "div.alert-danger"
	end

	test "password reset with invalid new password" do
	  post password_resets_path password_reset: { email: @user.email }
	  user = assigns(:user)
	  get edit_password_reset_path(user.pw_reset_token, email: user.email)
	  # Password and password confirmation does not match
	  patch password_reset_path(user.pw_reset_token), email: user.email, 
	  			user: { password: "foobar", password_confirmation: "somethingelse" }
	  assert_select "div#error_message"
	  # Blank password
	  patch password_reset_path(user.pw_reset_token, email: user.email),
	  			user: {password: " ", password_confirmation: " "}
	  assert_select "div#error_message"
	end

	test "password reset with expired token" do
	  post password_resets_path password_reset: { email: @user.email }
	  user = assigns(:user)
	  user.update_attribute(:pw_reset_sent_at, 3.hours.ago)
	  patch password_reset_path(user.pw_reset_token), email: user.email,
	  			user: { password: "foobar", password_confirmation: "foobar" }
	  assert_response :redirect
	  follow_redirect!
	  assert_match /expired/i, response.body
	end

end
