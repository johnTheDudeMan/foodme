require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(	name: "Test Name",
  										email: "test@email.com",
  										password: "foobar",
  										password_confirmation: "foobar")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "name should no more than 40 characters" do
    @user.name = "z" * 41
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email should be no more than 255 characters" do
    @user.email = "e" * 244 + "@example.com"
  end

  test "email should be downcased" do
    @user.email = "TEST@example.com"
    @user.save
    assert_equal @user.email, "test@example.com"
  end

  test "email should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    #save @user so validation can check against it
    @user.save
    assert_not dup_user.valid?
  end

  test "email should have valid format" do
    valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn jj@dumb.8008.com]
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com not@valid..com]
    valid_emails.each do |e|
    	@user.email = e
    	assert @user.valid?
    end
    invalid_emails.each do |e|
    	@user.email = e
    	assert_not @user.valid?
    end
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password confirmation should be present" do
    @user.password_confirmation = " " * 7
    assert_not @user.valid?
  end

  test "password should be at least 6 characters" do
    @user.password = @user.password_confirmation = "12345"
    assert_not @user.valid?
  end

  test "password confirmation should match password" do
    @user.password_confirmation = "foobaz"
    assert_not @user.valid?
  end

  test "authenticated? should return false for user with nil digest" do
    assert_not @user.authenticated?(:remember, " ")
  end

end
