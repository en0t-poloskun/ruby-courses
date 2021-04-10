class Train
  attr_accessor :speed

  attr_reader :type, :wagons, :route, :current_station

  def route=(route)
    @route = route
    @current_station = route.stations.first
    current_station.add_train(self)
  end

  def initialize(number, type, wagons)
    @speed = 0
    @number = number
    @type = type
    @wagons = wagons
  end

  def move_next
    if current_station != route.stations.last
      current_station.send_train(self)
      @current_station = next_station
      current_station.add_train(self)
    end
  end

  def move_back
    if current_station != route.stations.first
      current_station.send_train(self)
      @current_station = previous_station
      current_station.add_train(self)
    end
  end

  def next_station
    route.stations[route.stations.index(current_station) + 1]
  end

  def previous_station
    current_station != route.stations.first ? route.stations[route.stations.index(current_station) - 1] : nil
  end

  def go
    self.speed = 50
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    if speed == 0
      @wagons += 1
    end
  end

  def delete_wagon
    if speed == 0
      @wagons -= 1
    end
  end
end