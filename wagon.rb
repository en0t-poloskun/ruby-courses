# frozen_string_literal: true

class Wagon
  include Manufacturer

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise 'Invalid type' if (type != 'грузовой') && (type != 'пассажирский')
  end
end
