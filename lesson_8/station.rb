# frozen_string_literal: true

require_relative 'modules/module_instance_counter'
require_relative 'modules/module_valid'
class Station
  include InstanceCounter
  include Valid

  attr_reader :name, :trains

  @@stations = []
  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
    register_instance
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

  def all_trains(&block)
    @trains.each(&block)
  end

  protected

  def validate!
    raise if name.nil?
  end
end
