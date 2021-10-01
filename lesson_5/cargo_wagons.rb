# frozen_string_literal: true

require_relative 'module_manufacturer'

class CargoWagons
  include Manufacturer

  attr_reader :type_wagon

  def initialize
    @type_wagon = 'cargo'
  end
end
