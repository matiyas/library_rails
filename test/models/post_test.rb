require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:user0_post0)
  end

  # Fields presence
  test 'title should be present' do
    @post.title = ''
    assert_not @post.valid?
  end

  test 'content should be present' do
    @post.content = ''
    assert_not @post.valid?
  end

  test 'post should be owned by user' do
    @post.user = nil
    assert_not @post.valid?
  end

  # Minimum length
  test 'title should have a minimum length' do
    @post.title = 'aa'
    assert_not @post.valid?
  end

  # Maximum length
  test 'title should have a maximum length' do
    @post.title = 'a' * 141
    assert_not @post.valid?
  end

  test 'content should have a maximum length' do
    @post.content = 'a' * 10_001
    assert_not @post.valid?
  end

  # Non-blank fields
  test 'title should not be blank' do
    @post.title = ' ' * 3
    assert_not @post.valid?
  end

  test 'content should not be blank' do
    @post.content = ' '
    assert_not @post.valid?
  end
end
