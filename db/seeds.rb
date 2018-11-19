User.create(name: 'admin1', email: 'admin@example.com', password: '123456',
            password_confirmation: '123456', role: :admin, confirmed_at: Time.now)

user = User.create(name: 'Damian Matyjaszek', email: 'dmatyjaszek@example.com',
                   password: '123456', password_confirmation: '123456',
                   confirmed_at: Time.now)

50.times do
  post = user.posts.create(title: Faker::Lorem.sentence,
                           content: Faker::Lorem.paragraph(100))
  post.update_attribute(:created_at, (rand * 100).days.ago)
end


10.times do
  user = User.create(name: Faker::Name.name, email: Faker::Internet.email,
                     password: '123456', password_confirmation: '123456',
                     confirmed_at: Time.now)

  10.times do
    post = user.posts.create(title: Faker::Lorem.sentence,
                             content: Faker::Lorem.paragraph(100))
    post.update_attribute(:created_at, (rand * 100).days.ago)
  end
end