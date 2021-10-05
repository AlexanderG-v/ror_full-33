# frozen_string_literal: true

require_relative 'modules/module_manufacturer'
class PassengerWagons
  include Manufacturer

  attr_accessor :seats_taken
  attr_reader :type_wagon, :count_seats

  def initialize(count_seats)
    @count_seats = count_seats
    @seats_taken = 0
    @type_wagon = 'passenger'
  end

  def add_seat
    self.seats_taken += 1 if seats_taken < count_seats
  end

  def free_seats
    count_seats - seats_taken
  end

  
end
