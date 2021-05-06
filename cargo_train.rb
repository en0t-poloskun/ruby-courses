# frozen_string_literal: true

class CargoTrain < Train
  validate :number, :presence
  validate :number, :required_type, String
  validate :number, :format, '/^[\da-zа-я]{3}-*[\da-zа-я]{2}$/i'

  def initialize(number)
    super(number, 'грузовой')
  end
end
