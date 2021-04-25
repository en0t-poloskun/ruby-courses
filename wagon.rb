# frozen_string_literal: true

class Wagon
  include Manufacturer

  attr_reader :type, :number

  def initialize(type, number = nil)
    @type = type
    @number = number
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Invalid type' if (type != 'грузовой') && (type != 'пассажирский')
  end
end
