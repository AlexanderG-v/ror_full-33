# frozen_string_literal: true

puts 'Введите дату в формате дд.мм.гггг.'
date = gets.split('.')
date.map!(&:to_i)

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

months[1] = 29 if ((date[2] % 4).zero? && date[2] % 100 != 0) || (date[2] % 400).zero?

num_day = 0
num = 1

while num < date[1]
  num_day += months[num]
  num += 1
end

num_day += date[0]

puts num_day
