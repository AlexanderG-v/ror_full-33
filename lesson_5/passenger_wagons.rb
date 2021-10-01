# frozen_string_literal: true
require_relative 'module_manufacturer'

class PassengerWagons
  include Manufacturer

  attr_reader :type_wagon

  def initialize
    @type_wagon = 'passenger'
  end
end
