# frozen_string_literal: true

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
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

  private

  attr_writer :trains # инстанс переменная, которая не изменяется напрямую в клиентском коде
end
