# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

puts 'Creating default AdminUser email: admin@reminiscens.com | password: 12345678'
if AdminUser.where(email: 'admin@reminiscens.com').exists?
  puts 'Default AdminUser exist already, So skipping ...'
else
  AdminUser.create!(email: 'admin@reminiscens.com', password: '12345678', password_confirmation: '12345678')
  puts 'Default AdminUser has been created'
end
