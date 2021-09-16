# frozen_string_literal: true

hash = {}
sum_total = 0

loop do
  puts 'Введите наименование товара:'
  name = gets.chomp
  break if name == 'стоп'

  puts 'Введите стоимость товара:'
  price = gets.to_f

  puts 'Введите кличество товара:'
  quantity = gets.to_f

  hash[name] = { price: price, quantity: quantity }
end

puts "Хэш - #{hash}"

hash.each do |key, value|
  sum_position = value[:price] * value[:quantity]
  sum_total += sum_position
  puts "Итоговая стоимость #{key} составляет: #{sum_position}"
end
puts "Итоговая стоимость всех товаров составляет: #{sum_total}"
