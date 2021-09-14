# frozen_string_literal: true

# - площадь треугольника

puts "Let's calculate the area of the triange?"
sleep 2
puts 'What is length of base of the triangle in sm?'
base = gets.chomp.to_f
puts 'Now indicate height of the triandge in sm'
height = gets.chomp.to_f

puts "The area of the triagle is #{0.5 * base * height} sm."
