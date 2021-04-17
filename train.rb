# frozen_string_literal: true

class Train
  include Manufacturer
  include InstanceCounter

  attr_accessor :speed

  attr_reader :type, :wagons, :route, :current_station, :number

  @@instances = []

  def self.find(number)
    @@instances.find { |train| train.number == number }
  end

  def route=(route)
    @route = route
    @current_station = route.stations.first
    current_station.add_train(self)
  end

  def initialize(number, type)
    @speed = 0
    @number = number
    @type = type
    @wagons = []
    @@instances << self
    register_instance
  end

  def move_next
    return unless next_station

    current_station.send_train(self)
    self.current_station = next_station
    current_station.add_train(self)
  end

  def move_back
    return unless previous_station

    current_station.send_train(self)
    self.current_station = previous_station
    current_station.add_train(self)
  end

  def go
    self.speed = 50
  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    return if type != wagon.type

    wagons << wagon
  end

  def delete_wagon(wagon)
    return if type != wagon.type

    wagons.delete(wagon)
  end

  protected

  attr_writer :type, :wagons, :current_station # инстанс переменные, значения которых нельзя задавать в клиентском коде

  # методы не вызываются в клиентском коде

  def next_station
    route.stations[route.stations.index(current_station) + 1]
  end

  def previous_station
    current_station != route.stations.first ? route.stations[route.stations.index(current_station) - 1] : nil
  end
end
