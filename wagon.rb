# frozen_string_literal: true

class Wagon
  include Manufacturer

  attr_reader :type

  def initialize(type)
    @type = type
  end
end
