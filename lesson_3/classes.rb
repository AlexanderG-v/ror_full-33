# frozen_string_literal: true

class Station
  # - При создании экземпляра класса указывается имя экземпляра. Может возвращать список всех поездов на станции, находящихся в текущий мометн
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  # - принимает поезда (по одному за раз)
  def arrival(train)
    @trains << train
  end

  # - возвращает список поездов на станции по типу: кол-во грузовых, пассажирских
  def train_type(type)
    @trains.select { |train| train.type == type }
  end

  # - отправляет поезда (по одному за раз, при этом, поезд удаляется из спискапоездов, находящихся на станции)
  def departure(train)
    @trains.delete(train)
  end
end

class Route
  # - При создании экземпляра класса указывается начальная и конечная станции
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
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

class Train
  # - при создании экземпляра класса указывается номер (произвольная строка) и тип (грузовой, пассажирский) и кол-во вагонов
  attr_accessor :current_speed, :wagons
  attr_reader :type

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons.to_i
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
  def add_wagons
    self.wagons += 1 if self.current_speed.zero?
  end

  # - отцепляет вагоны(по одному вагону за операцию) при условии, что поезд не движется
  def remove_wagons
    self.wagons -= 1 if self.current_speed.zero?
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
    if @current_station != @route.stations.first
      @route.stations[@route.stations.index(@current_station) - 1]
    end
  end
  # - возвращает следующую станцию, на основе маршрута
  def next_station
    if @current_station != @route.stations.last
      @route.stations[@route.stations.index(@current_station) + 1]
    end
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
