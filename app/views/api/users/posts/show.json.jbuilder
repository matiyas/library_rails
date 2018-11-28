json.post do
  json.id @post.id
  json.title @post.title
  json.content @post.content
  json.created_at @post.created_at
  json.user_name @post.user.name
  json.user_profile_url profile_path(@post.user)
end
