Rails.logger.info { 'Start seeding!' }
users = [
  { email: 'test1234@gmail.com', password: 'test1234' }
]

users.each do |user|
  User.create!(user)
end

Rails.logger.info { 'Seeding done!' }