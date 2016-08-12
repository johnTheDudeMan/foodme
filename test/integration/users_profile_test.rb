require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:baci)
  end

  test "profile display" do
    log_in_as @user
    get user_path @user
    assert_template 'users/show'
    assert_select 'title', "#{@user.name} | FOODme"
    assert_select 'h5', text: @user.name
    assert_select '.avatar-profile'
    # TO DO: find way to test if avatar is uploaded and displayed
    # avatar = fixture_file_upload('test/fixtures/avatar.png', 'image/png')
    # patch user_path @user, params: { user: { avatar: avatar }}
  end

 end
