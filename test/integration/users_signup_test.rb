require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "signup with invalid information" do
	  get signup_path
	  assert_no_difference 'User.count' do
	    post signup_path, user: { 	name: "  ",
	    													email: "not@valid",
	    													password: "foo",
	    													password_confirmation: "baz" }
	  end
	  assert_template 'users/new'
	  assert_select 'div#error_message'
	  assert_select 'div.alert-danger' 
	end

	test "signup with valid information" do
	  get signup_path
	  assert_difference 'User.count', 1 do
	    post signup_path, user: { name: "Rick-C130",
	    													email: "therealrick@example.com",
	    													password: "wubalubadubdub",
	    													password_confirmation: "wubalubadubdub" }
	  end
	  follow_redirect!
	  assert_select 'div.alert-success', "Hello Rick-C130, welcome to FOODme!"
	end
end
