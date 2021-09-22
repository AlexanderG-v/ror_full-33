# frozen_string_literal: true

class Station
  attr_reader :trains

  def initialize(name_station)
    @name_station = name_station
    @trains = []
  end

  def arrival_train(name_train)
    @trains << name_train
  end
end

class Route
  def initialize(starting_station, ending_station)
    @intermediate_station = [starting_station, ending_station]
  end

  def adding_stations(name_station)
    @intermediate_station.insert(-2, name_station)
  end

  def delete_station(name_station)
    @intermediate_station.delete(name_station)
  end

  def show_stations
    @intermediate_station.each { |name| puts name }
  end
end

class Train
  attr_reader :current_speed, :wagons

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
