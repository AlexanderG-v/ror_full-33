# frozen_string_literal: true

# - идеальный вес

puts 'What is your name?'
name = gets.chomp
puts 'What is your height?'
height = gets.chomp.to_f

weight = (height - 110) * 1.15

if weight >= 0
  puts "Hi #{name}, your ideal weight #{weight.round(2)} kg."
else
  puts 'Your weight is already in use.'
end
