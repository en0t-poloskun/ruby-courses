class Route
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @middle_stations = []
  end

  def add_station(station)
    @middle_stations << station
  end

  def delete_station(station)
    @middle_stations.delete(station)
  end

  def show_route
    puts @start_station
    @middle_stations.each { |station| puts station }
    puts @end_station
  end
end