# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

num_users = 100
num_users.times do
  name = Faker::Name.name
  User.create(name: name, email: Faker::Internet.email, username: Faker::Internet.user_name(name), password: "password", password2: "password")
end

num_children = 10
num_children.times do
  Child.create(name: Faker::Name.name, description: Faker::Hacker.say_something_smart, picture: Faker::Internet.domain_name, user_id: rand(1..num_users))
end

num_posts = 1000
num_posts.times do
  Post.create(content: Faker::Lorem.paragraph(10), picture: Faker::Internet.domain_name, user_id: rand(1..num_users), child_id: rand(1..num_children))
end
