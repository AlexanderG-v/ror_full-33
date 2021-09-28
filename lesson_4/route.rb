# frozen_string_literal: true

class Route
  # - При создании экземпляра класса указывается начальная и конечная станции
  attr_reader :stations, :name

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name = [first_station.name, last_station.name]
  end

  # - добовляет промежуточную станцию в список
  def add_stations(station)
    @stations.insert(-2, station)
  end

  # - удаляет промежуточную станцию из списка
  def delete_station(station)
    @stations.delete(station)
  end

  # - выводит список всех станций по-порядку от начала до конца
  def show_stations
    @stations.each { |station| puts station.name.to_s }
  end

  # - при назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте
  def add_train(train)
    @stations[0].arrival(train)
  end
end
