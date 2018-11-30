json.post do
  json.id @post.id
  json.title @post.title
  json.content @post.content
  json.image @post.image
end