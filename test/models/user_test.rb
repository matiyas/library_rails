# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'example-user@example.com',
                     password: '123456')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  # Fields presence
  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'password should be present' do
    @user.password = ''
    assert_not @user.valid?
  end

  # Fields minimum length
  test 'name should have a minimum length' do
    @user.name = 'a' * 5
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = 'a' * 5
    assert_not @user.valid?
  end

  # Fields maximum length
  test 'name should have a maximum length' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should have a maximum length' do
    @user.email = 'a' * 255
    assert_not @user.valid?
  end

  test 'password should have a maximum length' do
    @user.password = 'a' * 21
  end

  # Non-blank fields
  test 'name should be non-blank' do
    @user.name = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should be non-blank' do
    @user.password = ' ' * 6
    assert_not @user.valid?
  end

  # Email validation
  test 'email should reject invalid addresses' do
    invalid_addresses = [
      'Abc.example.com',
      'A@b@c@example.com',
      'a"b(c)d,e:f;g<h>i[j\k]l@example.com',
      'just"not"right@example.com',
      # 'a' * 125 + '@example.com',
      # 'john..doe@example.com',
      'john.doe@example..com'
    ]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?
    end
  end

  test 'email should accept valid addresses' do
    valid_addresses = %w[
      simple@example.com
      very.common@example.com
      disposable.style.email.with+symbol@example.com
      other.email-with-hyphen@example.com
      fully-qualified-domain@example.com
      user.name+tag+sorting@example.com
      x@example.com
      example-indeed@strange-example.com
      admin@mailserver1
      example@s.example
    ]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?
    end
  end


  test 'email should be unique' do
    @user.save
    other_user = User.new(name: 'Other User', email: @user.email.dup,
                          password: '123456')
    assert_not other_user.valid?
  end

  test 'name can be duplicate' do
    @user.save
    other_user = User.new(name: @user.name.dup, email: 'other@example.com',
                          password: '123456')
    assert other_user.valid?
  end

  test 'password can be duplicate' do
    @user.save
    other_user = User.new(name: 'Other User', email: 'other@example.com',
                          password: @user.password.dup)
    assert other_user.valid?
  end
end
