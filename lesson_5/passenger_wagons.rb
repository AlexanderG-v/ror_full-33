# frozen_string_literal: true
require_relative 'modules/module_manufacturer.rb'
class PassengerWagons
  include Manufacturer

  attr_reader :type_wagon

  def initialize
    @type_wagon = 'passenger'
  end
end
