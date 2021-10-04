# frozen_string_literal: true

require_relative 'modules/module_instance_counter'
require_relative 'modules/module_valid'
class Station
  # - При создании экземпляра класса указывается имя экземпляра. Может возвращать список всех поездов на станции, находящихся в текущий мометн
  include InstanceCounter
  include Valid

  attr_reader :name, :trains

  @@stations = []
  # возвращает все станции (объекты), созданные на данный момент
  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
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

  protected

  # - проверка на наличие атрибута name
  def validate!
    raise if name.nil?
  end
end
