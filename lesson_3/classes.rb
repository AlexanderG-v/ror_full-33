
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