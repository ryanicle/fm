require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    Rails.application.load_seed
  end
  # test "the truth" do
  #   assert true
  # end
  test "Create user" do
    user = User.new(email: 'test3@example.com', password: 'User#Test')
    assert user.save
  end

  test "Should not create user if email already exists" do
    user = User.new(email: 'test1@example.com', password: 'User#Test')
    assert_not user.save
  end
end
