# frozen_string_literal: true

require_relative 'modules/module_instance_counter'
require_relative 'modules/module_manufacturer'
require_relative 'modules/module_valid'

class Train
  NUMBER_FORMATE = /^[\w\d]{3}.[\w\d]{2}$/i.freeze
  include Manufacturer
  include InstanceCounter
  include Valid

  attr_accessor :wagons
  attr_reader :current_speed, :number, :current_station

  @@trains = {}
  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @wagons = []
    @current_speed = 0
    @@trains[number] = self
    validate!
    register_instance
  end

  def speed_up(speed)
    self.current_speed += speed
  end

  def stop
    self.current_speed = 0
  end

  def add_wagons(wagon)
    wagons << wagon if wagon.type_wagon == @type_train && self.current_speed.zero?
  end

  def remove_wagons(wagon)
    wagons.delete(wagon) if wagon.type_wagon == @type_train && self.current_speed.zero?
  end

  def add_route(route)
    @route = route
    @current_station = @route.stations.first
    @route.add_train(self)
  end

  def previous_station
    return unless @current_station != @route.stations.first

    @route.stations[@route.stations.index(@current_station) - 1]
  end

  def next_station
    return unless @current_station != @route.stations.last

    @route.stations[@route.stations.index(@current_station) + 1]
  end

  def go_forward
    return unless next_station

    @current_station.departure(self)
    @current_station = next_station
    @current_station.arrival(self)
  end

  def go_back
    return unless previous_station

    @current_station.departure(self)
    @current_station = previous_station
    @current_station.arrival(self)
  end

  def all_wagons(&block)
    @wagons.each(&block)
  end

  protected

  def validate!
    raise if number.nil?
    raise if number !~ NUMBER_FORMATE
  end

  private

  attr_writer :current_speed
end
