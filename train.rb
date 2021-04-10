class Train
  attr_accessor :speed

  attr_reader :type, :wagons

  def initialize(number, type, wagons)
    @speed = 0
    @number = number
    @type = type
    @wagons = wagons
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    if speed == 0
      @wagons += 1
    end
  end

  def delete_wagon
    if speed == 0
      @wagons -= 1
    end
  end
end