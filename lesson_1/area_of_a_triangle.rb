# frozen_string_literal: true

# - площадь треугольника

puts "Let's calculate the area of the triange?"
sleep 2
puts 'What is length of base of the triangle in sm?'
base = gets.chomp
puts 'Now indicate height of the triandge in sm'
height = gets.chomp

puts "The area of the triagle is #{0.5 * base.to_i * height.to_i} sm."
