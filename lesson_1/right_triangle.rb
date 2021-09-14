# frozen_string_literal: true

# - прямоугольный треугольник

puts 'Please, enter length of three sides of the triangle.'
sleep 1
puts 'Side A'
size_a = gets.chomp
puts 'Side B'
size_b = gets.chomp
puts 'Side C'
size_c = gets.chomp

arr = [size_a, size_b, size_c].map!(&:to_i)
a, b, c = arr.sort

if c**2 == a**2 + b**2
  puts 'Right triangle!'
elsif arr.sum / arr.size == a
  puts 'Equilateral triangular!'
elsif a == b || b == c || c == a
  puts 'Isosceles or quilateral triangle!'
end
