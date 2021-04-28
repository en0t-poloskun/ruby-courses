# frozen_string_literal: true

class Station
  include InstanceCounter

  include Accessors

  attr_reader :trains, :name

  attr_accessor_with_history :a, :b

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

  def add(train)
    trains << train
  end

  def send(train)
    trains.delete(train)
  end

  def get_trains_by(type)
    trains.filter { |train| train.type == type }
  end

  def count(type)
    get_trains_by(type).size
  end

  def show_trains
    trains.each { |train| puts train.number }
  end

  def trains_iterator(&block)
    trains.each { |train| block.call(train) }
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
