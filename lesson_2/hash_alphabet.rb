# frozen_string_literal: true

alph = ('a'..'z').to_a
vowels = %w[a e i o u y]
hash = {}

alph.each_with_index do |item, index|
  index += 1
  vowels.each do |vowel|
    hash[vowel] = index if item == vowel
  end
end