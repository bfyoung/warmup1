require 'test_helper'

class UserTest < ActiveSupport::TestCase

    test "empty user returns -3" do
      User.resetFixture
      assert_equal User.add('','password'), -3
      User.resetFixture
    end

    test "long password returns -4" do
      assert_equal User.add('user',' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae risus velit. Nam quis dui at sem iaculis ornare. Ut volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae risus velit. Nam quis dui at sem iaculis ornare. Ut volutpat.'), -4
      User.resetFixture
    end

    test "resetFixture returns 1" do
      assert_equal User.resetFixture, 1
      User.resetFixture
    end

    test "if user is added, return 1" do
      assert_equal User.add('user','password'), 1
      User.resetFixture
    end

    test "if user is not found, return -1" do
      assert_equal User.login('thisuser', 'doesnotexist'), -1
      User.resetFixture
    end
    
    test "if user is found, return count" do
      User.add('user','password')
      assert_equal User.login('user','password'), 2
      User.resetFixture
    end

    test "if password is wrong, return -1" do
      User.add('user','password')
      assert_equal User.login('user','pw'), -1
      User.resetFixture
    end

    test "if trying to add existing user, return -2" do
      User.add('user', 'password')
      assert_equal User.add('user','password'), -2
      User.resetFixture
    end

    test "if name is too long, return -3" do
      assert_equal User.add('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae risus velit. Nam quis dui at sem iaculis ornare. Ut volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae risus velit. Nam quis dui at sem iaculis ornare. Ut volutpat.', 'password'), -3
      User.resetFixture
    end

    test "If password is empty, return 1" do
      assert_equal User.add('user', ''), 1
      User.resetFixture
    end

      
end
