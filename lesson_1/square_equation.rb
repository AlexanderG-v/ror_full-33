# frozen_string_literal: true

# - квадратное уровнение

puts 'Hi! Enter 3 coefficients.'
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

d = b**2 - 4 * a * b

if d.positive?
  x_1 = (-b + Math.sqrt(d)) / (2.0 * a)
  x_2 = (-b - Math.sqrt(d)) / (2.0 * a)
  puts "Discriminant = #{d}, root_1 = #{x_1.round(2)}, root_2 = #{x_2.round(2)}"
elsif d.zero?
  x = -b / (2.0 * a)
  puts "Discriminant = #{d}, root_1 = #{x.round(2)}"
elsif d.negative?
  puts "#{d} No root!"

end
