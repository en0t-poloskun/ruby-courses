# frozen_string_literal: true

class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@instances = []

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@instances << self
    register_instance
  end

  def add_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def get_trains_by_type(type)
    trains.filter { |train| train.type == type }
  end

  def count_type(type)
    get_trains_by_type(type).size
  end

  def show_trains
    trains.each { |train| puts train.number }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  attr_writer :trains

  def validate!
    raise "Name can't be empty" if name.empty?
  end
end
