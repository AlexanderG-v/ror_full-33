# frozen_string_literal: true

class Train
  # - при создании экземпляра класса указывается номер (произвольная строка) и тип (грузовой, пассажирский) и кол-во вагонов
  attr_accessor :current_speed, :wagons
  attr_reader :type

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @current_speed = 0
  end

  # - набирает скорость
  def speed_up(speed)
    self.current_speed += speed
  end

  # - тормозит (сбрасывает скорость до нуля)
  def stop
    self.current_speed = 0
  end

  # - прицепляет вагоны(по одному вагону за операцию) при условии, что поезд не движется
  def add_wagons(type_wagon)
    wagons << type_wagon if self.current_speed.zero?
  end

  # - отцепляет вагоны(по одному вагону за операцию) при условии, что поезд не движется
  def remove_wagons(type_wagon)
    wagons.delete(type_wagon) if self.current_speed.zero?
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
end
