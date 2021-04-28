# frozen_string_literal: true

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    register_instance
  end

  def add(station)
    stations.insert(-2, station)
  end

  def delete(station)
    stations.delete(station)
  end

  def show_route
    stations.each { |station| puts station.name }
  end

  private

  attr_writer :stations
end
