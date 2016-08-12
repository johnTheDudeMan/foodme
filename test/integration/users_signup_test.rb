require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "signup with invalid information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, user: {   name: "  ",
                                email: "not@valid",
                                password: "foo",
                                password_confirmation: "baz" }
    end
    assert_template 'users/new'
    assert_select 'div#error_message'
    assert_select 'div.alert-danger' 
  end

  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, user: { name: "Rick-C130",
                                email: "therealrick@example.com",
                                password: "wubalubadubdub",
                                password_confirmation: "wubalubadubdub" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select 'div.alert-info'
    assert_not user.activated?
    # Invalid activation token
    get edit_account_activation_path("wrong token", email: user.email)
    follow_redirect!
    assert_select 'div.alert-danger'
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    follow_redirect!
    assert_template "static_pages/home"
    assert user.reload.activated?
    assert is_logged_in?
  end
end
