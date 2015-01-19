# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
require 'csv'

puts 'Creating default AdminUser email: admin@reminiscens.com | password: 12345678'
if AdminUser.where(email: 'admin@reminiscens.com').exists?
  puts 'Default AdminUser exist already, So skipping ...'
else
  AdminUser.create!(email: 'admin@reminiscens.com', password: '12345678', password_confirmation: '12345678')
  puts 'Default AdminUser has been created'
end

puts 'Creating predefined StoryContexts ...'
# TODO
puts 'Creating predefined StoryThemes ...'
# TODO

puts 'Creating predefined Questions ...'
question_themes_from_csv = []
csv_text = File.read("#{Rails.root}/db/question_seeds.csv")
csv = CSV.parse(csv_text, headers: false)
theme_texts = csv.reject { |r| !r[2].present? }.collect { |r| r[2] }.uniq
theme_texts.each do |theme_name|
  theme = Theme.find_or_initialize_by(name: theme_name)
  if theme.new_record?
    puts "Creating theme: #{theme.name}"
    theme.source = Theme::SOURCE_PREDEFINED
    theme.save
  end
  question_themes_from_csv << theme
end

csv.each do |row|
  content_text = row[0]
  theme_text = row[2]
  theme = question_themes_from_csv.detect{|t| t.name == theme_text}
  question = Question.find_or_initialize_by(content: content_text)
  question.theme = theme if theme.present?
  if question.new_record?
    puts "Creating question: #{question.content}"
  else
    puts "Updating question: #{question.content}"
  end
  question.save
end