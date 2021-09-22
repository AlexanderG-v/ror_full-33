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

  # - повторяется в классе Станций
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
end
