require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:baci)
    @other_user = users(:hotdog)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    get :show, id: @user
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not correct user" do
    log_in_as @other_user
    get :edit, id: @user
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect update when not correct user" do
    log_in_as @other_user
    patch :update, id: @user, user: { name: @other_user.name, email: @other_user.email }
    assert_redirected_to root_url
  end

  test "should not allow updating admin through the web" do
    log_in_as @other_user
    patch :update, id: @other_user, user: { name: @other_user.name, email: @other_user.email, admin: true }
    assert_not @other_user.reload.admin?
  end

  test "should redirect destroy as a non-admin" do
    log_in_as @other_user
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

end
