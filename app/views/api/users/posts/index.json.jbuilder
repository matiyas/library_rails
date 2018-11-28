json.posts @posts.each do |post|
  json.user_name post.user.name
  json.user_url profile_path(post.user)
  json.url api_users_post_path(post)
  json.id post.id
  json.title post.title
  json.content post.content
  json.created_at post.created_at
end