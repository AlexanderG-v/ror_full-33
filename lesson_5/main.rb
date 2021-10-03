# frozen_string_literal: true

require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'cargo_wagons'
require_relative 'passenger_wagons'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'tui'

puts 'Добро пожаловать на пульт управления поездами!'
puts '=============================================='

tui = TextUserInterface.new
tui.item_selection
