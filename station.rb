# frozen_string_literal: true

class Station
  include Validation
  include Accessors
  include InstanceCounter

  attr_reader :trains, :name

  validate :name, :presence
  validate :name, :required_type, String

  @@instances = []

  def self.all
    @@instancess
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

  def delete(train)
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

  private

  attr_writer :trains
end
