# frozen_string_literal: true

class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrival(train)
    @trains << train
  end

  def train_type(type)
    @trains.select { |train| train.type == type }
  end

  def departure(train)
    @trains.delete(train)
  end
end

class Route
  def initialize(starting_station, ending_station)
    @intermediate_station = [starting_station, ending_station]
  end

  def adding_stations(station)
    @intermediate_station.insert(-2, station)
  end

  def delete_station(station)
    @intermediate_station.delete(station)
  end

  def show_stations
    @intermediate_station.each { |name| puts name }
  end
end

class Train
  attr_reader :current_speed, :wagons, :type

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons.to_i
    @current_speed = 0
  end

  def speed_up(speed)
    @current_speed += speed
  end

  def stop
    @current_speed = 0
  end

  def add_wagons
    @wagons += 1 if @current_speed.zero?
  end

  def remove_wagons
    @wagons -= 1 if @current_speed.zero?
  end
end
