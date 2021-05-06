# frozen_string_literal: true

class Wagon
  include Validation
  include Manufacturer

  attr_reader :type, :number

  validate :type, :presence
  validate :type, :required_type, String
  validate :type, :format, '/^(грузовой|пассажирский)$/'

  def initialize(type, number = nil)
    @type = type
    @number = number
    validate!
  end
end
