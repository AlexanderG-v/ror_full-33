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
