# frozen_string_literal: true

class PassengerWagon < Wagon
  attr_reader :occupied_seats

  def initialize(seats)
    @seats = seats
    @occupied_seats = 0
    super('пассажирский')
  end

  def take_seat
    return if occupied_seats == seats

    self.occupied_seats += 1
  end

  def free_seats
    seats - occupied_seats
  end

  private

  attr_accessor :seats
  attr_writer :occupied_seats

  def validate!
    raise 'Invalid number of seats' if seats.negative?
  end
end
