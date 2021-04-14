require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'

class Main
  def initialize
    @stations = []
    @trains = []
    @routs = []
    @wagons = []
  end

  def menu
    while true
      puts("\n 1. Создать станцию\n 2. Cоздать поезд\n 3. Создать маршрут\n 4. Создать вагон\n 5. Изменить существующий маршрут\n" + 
      " 6. Назначать маршрут поезду\n 7. Добавлять/отцепить вагон\n 8. Переместить поезд\n 9. Посмотреть список станций\n" + 
      "10. Посмотреть список поездов на станции\n 0. Выйти из меню\n\n")
      printf("Введите номер операции: ")
      n = gets.to_i
      case n
      when 0
        return
      when 1
        create_station
      when 2
        "smth"
      when 3
        "smth"
      when 4
        "smth"
      when 5
        "smth"
      when 6
        "smth"
      when 7
        "smth"
      when 8
        "smth"
      when 9
        show_stations
      when 10
        "smth"
      end
    end
  end

  private

  attr_accessor :stations

  def create_station
    printf("Введите название станции: ")
    name = gets
    stations << Station.new(name)
    puts("Станция успешно создана!")
  end

  def show_stations
    puts("Список всех станций:")
    stations.each_with_index { |station, i| puts "#{i+1}. #{station.name}" }
  end

end