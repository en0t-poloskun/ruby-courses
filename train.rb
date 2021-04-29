# frozen_string_literal: true

class Train
  include Manufacturer, InstanceCounter, Validation

  attr_accessor :speed

  attr_reader :type, :wagons, :route, :current_station, :number

  validate :number, :presence
  validate :number, :required_type, String
  validate :number, :format, '/^[\da-zа-я]{3}-*[\da-zа-я]{2}$/i'
  validate :type, :presence
  validate :type, :required_type, String
  validate :type, :format, '/^(грузовой|пассажирский)$/'

  @@instances = {}

  def self.find(number)
    @@instances[number]
  end

  def route=(route)
    @route = route
    @current_station = route.stations.first
    current_station.add(self)
  end

  def initialize(number, type)
    @speed = 0
    @number = number
    @type = type
    @wagons = []
    validate!
    @@instances[number] = self
    register_instance
  end

  def move_next
    return unless next_station

    current_station.delete(self)
    self.current_station = next_station
    current_station.add(self)
  end

  def move_back
    return unless previous_station

    current_station.delete(self)
    self.current_station = previous_station
    current_station.add(self)
  end

  def go
    self.speed = 50
  end

  def stop
    self.speed = 0
  end

  def add(wagon)
    return if type != wagon.type

    wagons << wagon
  end

  def delete(wagon)
    return if type != wagon.type

    wagons.delete(wagon)
  end

  def wagons_iterator(&block)
    wagons.each { |wagon| block.call(wagon) }
  end

  protected

  attr_writer :type, :wagons, :current_station

  def next_station
    route.stations[route.stations.index(current_station) + 1]
  end

  def previous_station
    current_station != route.stations.first ? route.stations[route.stations.index(current_station) - 1] : nil
  end
end
