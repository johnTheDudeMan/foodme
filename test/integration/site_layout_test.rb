require 'test_helper'

class SityLayoutTest < ActionDispatch::IntegrationTest
  
  test "layout links for non-logged-in users" do
  	get root_path
  	assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", users_path, count: 1
    assert_select "a[href=?]", about_path, count: 2
    assert_select "a[href=?]", contact_path, count: 1
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", "https://github.com/johnTheDudeMan/foodme"
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
  end

  # Layout links for logged in users will go here
end
