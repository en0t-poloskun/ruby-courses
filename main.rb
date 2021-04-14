require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'

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
        create_train
      when 3
        create_route
      when 4
        create_wagon
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

  attr_accessor :stations, :trains, :routs, :wagons

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

  def create_train
    puts("\n 1. Создать грузовой поезд\n 2. Cоздать пассажирский поезд\n\n")
    printf("Введите номер операции: ")
    n = gets.to_i
    printf("Введите номер поезда: ")
    number = gets
    if n == 1
      trains << CargoTrain.new(number)
    elsif n == 2
      trains << PassengerTrain.new(number)
    end
    puts("Поезд успешно создан!")
  end

  def create_route
    show_stations
    printf("Введите номер начальной станции: ")
    start = gets.to_i
    printf("Введите номер конечной станции: ")
    finish = gets.to_i
    routs << Route.new(stations[start - 1], stations[finish - 1])
    puts("Маршрут успешно создан!")
  end

  def create_wagon
    puts("\n 1. Создать грузовой вагон\n 2. Cоздать пассажирский вагон\n\n")
    printf("Введите номер операции: ")
    n = gets.to_i
    if n == 1
      wagons << CargoWagon.new
    elsif n == 2
      wagons << PassengerWagon.new
    end
    puts("Вагон успешно создан!")
    puts(wagons)
  end

end