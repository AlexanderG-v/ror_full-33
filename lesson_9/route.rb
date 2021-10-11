# frozen_string_literal: true

require_relative 'modules/module_instance_counter'
require_relative 'modules/module_accessors'
require_relative 'modules/module_validation'

class Route
  include InstanceCounter
  extend Accessors
  include Validation

  attr_reader :stations, :name

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name = stations.first.name, stations.last.name
    validate!
    register_instance
  end

  def add_stations(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def show_stations
    @stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}." }
  end

  def add_train(train)
    @stations.first.arrival(train)
  end
end
