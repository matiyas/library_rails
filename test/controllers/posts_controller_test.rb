require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = users(:admin)
    @user0 = users(:user0)
    @user1_post0 = posts(:user1_post0)
    @post = posts(:test_post)
  end

  # Not logged in
  test 'should get index' do
    get users_posts_path
    assert_response :success
  end

  test 'should get show' do
    get users_post_path @post
    assert_response :success
  end

  test 'should not get new when not logged in' do
    get new_users_post_path
    assert_redirected_to_login
  end

  test 'should not get edit when not logged in' do
    get edit_users_post_path @post
    assert_redirected_to_login
  end

  test 'should not allow create when not logged in' do
    assert_no_difference 'Post.count' do
      post users_posts_path, params: { 
        post: { title: 'Title', content: 'Content' }
      }
    end
    assert_redirected_to_login
  end

  test 'should not allow edit when not logged in' do
    assert_no_changes '@post.title' do
      patch users_post_path(@post), params: { post: { title: 'New Title' } }
    end
    assert_redirected_to_login
  end

  test 'should not allow destroy when not logged in' do
    assert_no_difference 'Post.count' do
      delete users_post_path @user1_post0
    end
    assert_redirected_to_login
  end

  # Logged in as unprivileged user
  test 'should not allow edit when non-owner and non-admin' do
    sign_in @user0
    assert_raises CanCan::AccessDenied do
      patch users_post_path(@user1_post0), params: {
        post: { title: 'New Title' }
      }
    end
  end

  test 'should not allow delete when non-owner and non-admin' do
    sign_in @user0
    assert_raises CanCan::AccessDenied do
      delete users_post_path @user1_post0
    end
  end

  # Logged as privileged user
  test 'should get new when logged in' do
    sign_in @user0
    get new_users_post_path
    assert_response :success
  end

  test 'should get edit when logged in as owner' do
    sign_in @user0
    get edit_users_post_path @post
    assert_response :success
  end

  test 'should allow create when logged in' do
    sign_in @user0
    assert_difference 'Post.count', 1 do
      post users_posts_path, params: { 
        post: { title: 'Title', content: 'Content' }
      }
    end
  end

  test 'should allow edit when logged in as post owner' do
    sign_in @user0
    assert_changes '@post.title', to: 'New Title' do
      patch users_post_path(@post), params: { post: { title: 'New Title' } }
      @post.reload
    end
  end

  test 'should allow delete when logged in as post owner' do
    sign_in @user0
    assert_difference 'Post.count', -1 do
      delete users_post_path @post
    end
  end

  # Logged as admin
  test 'should allow edit when logged in as admin' do
    sign_in @admin
    assert_changes '@post.title', to: 'New Title' do
      patch users_post_path(@post), params: {
        post: { title: 'New Title' }
      }
      @post.reload
    end
  end

  test 'should allow delete when logged in as admin' do
    sign_in @user0
    assert_difference 'Post.count', -1 do
      delete users_post_path @post
    end
  end
end
