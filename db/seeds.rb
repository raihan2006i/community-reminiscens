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
contexts = []
context_seeds = File.read("#{Rails.root}/db/context_seeds.csv")
context_seed_rows = CSV.parse(context_seeds, headers: false)
context_seed_rows.each do |row|
  context_name = row.join(',')
  context = Context.find_or_initialize_by(name: context_name)
  if context.new_record?
    puts "Creating context: #{context.name}"
    context.source = Context::SOURCE_PREDEFINED
    context.save
  end
  contexts << context
end

puts 'Creating predefined StoryThemes ...'
themes = []
theme_seeds = File.read("#{Rails.root}/db/theme_seeds.csv")
theme_seed_rows = CSV.parse(theme_seeds, headers: false)
theme_seed_rows.each do |row|
  theme_name = row.join(',')
  theme = Theme.find_or_initialize_by(name: theme_name)
  if theme.new_record?
    puts "Creating theme: #{theme.name}"
    theme.source = Theme::SOURCE_PREDEFINED
    theme.save
  end
  themes << theme
end

puts 'Creating predefined Questions ...'
question_seeds = File.read("#{Rails.root}/db/question_seeds.csv")
question_seed_rows = CSV.parse(question_seeds, headers: false)
theme_texts = question_seed_rows.reject { |r| !r[2].present? }.collect { |r| r[2] }.uniq
theme_texts.each do |theme_name|
  theme = Theme.find_or_initialize_by(name: theme_name)
  if theme.new_record?
    puts "Creating theme: #{theme.name}"
    theme.source = Theme::SOURCE_PREDEFINED
    theme.save
  end
  themes << theme
end

question_seed_rows.each do |row|
  content_text = row[0]
  theme_text = row[2]
  theme = themes.detect{|t| t.name == theme_text}
  question = Question.find_or_initialize_by(content: content_text)
  question.theme = theme if theme.present?
  if question.new_record?
    puts "Creating question: #{question.content}"
  else
    puts "Updating question: #{question.content}"
  end
  question.save
end