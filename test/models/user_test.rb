require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    Rails.application.load_seed
  end
  # test "the truth" do
  #   assert true
  # end
  test "Create user without email" do
    user = User.new(password: 'User#Test')
    assert_not user.save
  end

  test "Create user without password" do
    user = User.new(email: 'any@example.com')
    assert_not user.save
  end

  test "Create user" do
    user = User.new(email: 'amy@example.com', password: 'User#Test')
    assert user.save
  end

  test "Should not create user if email already exists" do
    user = User.new(email: 'john@example.com', password: 'User#Test')
    assert_not user.save
  end
end
