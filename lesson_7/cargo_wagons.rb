# frozen_string_literal: true

require_relative 'modules/module_manufacturer'
class CargoWagons
  include Manufacturer

  attr_accessor :filled_volume
  attr_reader :type_wagon, :volume

  def initialize(volume)
    @volume = volume
    @filled_volume = 0
    @type_wagon = 'cargo'
  end

  def load_volume(volume)
    self.filled_volume += volume if volume + @filled_volume <= @volume
  end

  def free_volume
    @volume - @filled_volume
  end
end
