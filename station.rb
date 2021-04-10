class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def get_trains_by_type(type)
    trains_by_type = []
    @trains.each do |train|
      if train.type == type
        trains_by_type << train
      end
    end
    trains_by_type
  end

  def count_type(type)
    n = 0
    @trains.each do |train|
      if train.type == type
        n += 1
      end
    end
    n
  end
end