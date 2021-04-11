class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @middle_stations.delete(station)
  end

  def show_route
    @stations.each { |station| puts station }
  end
end
