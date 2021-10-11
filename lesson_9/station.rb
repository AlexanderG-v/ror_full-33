# frozen_string_literal: true

require_relative 'modules/module_instance_counter'
require_relative 'modules/module_accessors'
require_relative 'modules/module_validation'
class Station
  NAME_FORMATE = /^.+$/i.freeze
  include InstanceCounter
  extend Accessors
  include Validation

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
end
