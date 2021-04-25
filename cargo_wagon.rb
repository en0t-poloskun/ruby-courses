# frozen_string_literal: true

class CargoWagon < Wagon
  attr_reader :occupied_volume

  def initialize(volume, number = nil)
    @volume = volume
    @occupied_volume = 0
    super('грузовой', number)
  end

  def fill_with(some_volume)
    return if some_volume > free_volume

    self.occupied_volume += some_volume
  end

  def free_volume
    volume - occupied_volume
  end

  private

  attr_accessor :volume
  attr_writer :occupied_volume

  def validate!
    raise 'Invalid volume' if volume.negative?
  end
end
