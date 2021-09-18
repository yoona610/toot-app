# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.find_or_create_by(id: 2) do |user|
  user.name = 'TOOT'
  user.email = 'toot@example.com'
  user.password = 'toot1234'
end

Admin.find_or_create_by(id: 2) do |admin|
  admin.email = 'toot-admin@example.com'
  admin.password = 'toot1234'
end
