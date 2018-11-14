50.times do
  user = User.create(name: Faker::Name.name, email: Faker::Internet.email,
                     password: '123456', password_confirmation: '123456')

  20.times do
    user.posts.create!(title: Faker::Lorem.sentence,
                       content: Faker::Lorem.paragraph(100))
  end
end