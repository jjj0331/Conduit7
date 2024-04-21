require "test_helper"
class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "Example User", 
                     email: "user@example.com", 
                     password: "password")
  end

  #user.rbで設定したバリデーションをすべて満たしているのかテスト
  test "user should be valid" do
    assert @user.valid?
  end

  #usernameが空白だった場合にfalseになるのかテスト
  test "user should be present" do
    @user.username="      "
    assert_not @user.valid? ,"user should be present"
  end

  #usernameが空白だった場合にfalseになるのかテスト
  test "email should be present" do
    @user.email="      "
    assert_not @user.valid? ,"email should be present"
  end

  #usernameが長すぎる場合はエラーになるテスト
  test "name should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid? ,"name should not be too long"
  end

  #emailが長すぎてエラーになるテスト
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid? ,"email should not be too long"
  end
  #emailの中に[@]が存在する
  test "must contain an @ symbol" do
    @user.email = "aexample.com"
    assert_not @user.valid? ,"must contain an @ symbol"
  end

  #passwordは5文字以上
  test "password should have a minimum length" do
    @user.password = "a" * 4
    assert_not @user.valid?
  end
  
end
