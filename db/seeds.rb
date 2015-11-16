# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(:name => 'Jorge André Pereira',
            :email => 'jahpereira@gmail.com',
            :password => 'topsecret',
            :password_confirmation => 'topsecret',
            :confirmed_at => DateTime.now,
            :admin => true)

# 9.times do |n|
#  name  = Faker::Name.name
#  email = "example-#{n+1}@data-xl.com"
#  password = "password"
#  User.create!(name:  name,
#              email: email,
#              password:              password,
#              password_confirmation: password,
#              admin:    false,
#              activated: true,
#              activated_at: Time.zone.now)
# end
