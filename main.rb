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
      " 6. Назначать маршрут поезду\n 7. Добавить/отцепить вагон\n 8. Переместить поезд\n 9. Посмотреть список станций\n" + 
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
        change_route
      when 6
        assign_route
      when 7
        change_wagons
      when 8
        move_train
      when 9
        show_stations
      when 10
        show_trains_at_staion
      end
    end
  end

  private

  attr_accessor :stations, :routs, :wagons, :trains

  def show_stations
    puts("Список всех станций:")
    stations.each_with_index { |station, i| puts "#{i+1}. #{station.name}" }
  end

  def show_trains
    puts("Список всех поездов:")
    trains.each_with_index { |train, i| puts "#{i+1}. #{train.number}" }
  end

  def show_wagons
    puts("Список всех вагонов:")
    wagons.each_with_index { |wagon, i| puts "#{i+1}. #{wagon.type}" }
  end

  def show_routs
    routs.each_with_index do |route, i| 
      puts("Маршрут №#{i+1}:")
      route.show_route
    end
  end

  def show_trains_at_staion
    show_stations
    printf("Введите номер станции: ")
    s = gets.to_i
    puts("Список поездов на станции:")
    stations[s-1].show_trains
  end

  def create_station
    printf("Введите название станции: ")
    name = gets
    stations << Station.new(name)
    puts("Станция успешно создана!")
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
  end

  def change_route
    show_routs
    printf("Введите номер маршрута для изменения: ")
    r = gets.to_i
    puts("\n 1. Добавить станцию\n 2. Удалить станцию\n\n")
    printf("Введите номер операции: ")
    n = gets.to_i
    show_stations
    printf("Введите номер станции: ")
    s = gets.to_i
    if n == 1
      routs[r-1].add_station(stations[s-1])
    elsif n == 2
      routs[r-1].delete_station(stations[s-1])
    end
    puts("Маршрут успешно изменен!")
  end

  def change_wagons
    show_trains
    printf("Введите номер поезда по списку: ")
    t = gets.to_i
    puts("\n 1. Добавить вагон\n 2. Отцепить вагон\n\n")
    printf("Введите номер операции: ")
    n = gets.to_i
    show_wagons
    printf("Введите номер вагона: ")
    w = gets.to_i
    if n == 1
      trains[t-1].add_wagon(wagons[w-1])
    elsif n == 2
      trains[t-1].delete_wagon(wagons[w-1])
    end
  end

  def assign_route
    show_trains
    printf("Введите номер поезда по списку: ")
    t = gets.to_i
    show_routs
    printf("Введите номер маршрута: ")
    r = gets.to_i
    trains[t-1].route = routs[r-1]
    puts("Маршрут назначен")
  end

  def move_train
    show_trains
    printf("Введите номер поезда по списку: ")
    t = gets.to_i
    puts("\n 1. Переместить поезд вперед\n 2. Переместить поезд назад\n\n")
    printf("Введите номер операции: ")
    n = gets.to_i
    if n == 1
      trains[t-1].move_next
    elsif n == 2
      trains[t-1].move_back
    end
    puts("Поезд перемещен")
  end

end