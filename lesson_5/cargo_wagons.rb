# frozen_string_literal: true

require_relative 'modules/module_manufacturer.rb'
class CargoWagons
  include Manufacturer

  attr_reader :type_wagon

  def initialize
    @type_wagon = 'cargo'
  end
end
