# frozen_string_literal: true

require_relative 'modules/module_instance_counter.rb'
require_relative 'modules/module_manufacturer.rb'
class Train
  include Manufacturer
  include InstanceCounter

  attr_accessor :wagons
  attr_reader :current_speed, :number

  @@trains = {}

  def self.find(namber)
    @@trains[namber]
  end

  def initialize(number)
    @number = number
    @wagons = []
    @current_speed = 0
    @@trains[number] = self
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

  # - принимает маршрут следования (экземпляр класса Route)
  # - при назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте
  def add_route(route)
    @route = route
    @current_station = @route.stations[0]
    @route.add_train(self)
  end

  # - возвращает предыдущую станцию, на основе маршрута
  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] if @current_station != @route.stations.first
  end

  # - возвращает следующую станцию, на основе маршрута
  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if @current_station != @route.stations.last
  end

  # - перемещение вперед между станциями, но только на одну станцию за раз
  def go_forward
    return unless next_station

    @current_station.departure(self)
    @current_station = next_station
    @current_station.arrival(self)
  end

  # - перемещение назад между станциями, но только на одну станцию за раз
  def go_back
    return unless previous_station

    @current_station.departure(self)
    @current_station = previous_station
    @current_station.arrival(self)
  end
  # занечени current_speed устанавливается общедоступными методами

  private

  attr_writer :current_speed
end
