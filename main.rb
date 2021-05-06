# frozen_string_literal: true

require_relative 'demonstration'
require_relative 'validation'
require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'accessors'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

class Main
  def initialize
    @stations = []
    @trains = []
    @routs = []
    @wagons = []
  end

  def menu
    loop do
      puts("\n 1. Создать станцию\n 2. Cоздать поезд\n 3. Создать маршрут\n 4. Создать вагон\n" \
      " 5. Изменить существующий маршрут\n 6. Назначать маршрут поезду\n 7. Добавить/отцепить вагон\n" \
      " 8. Переместить поезд\n 9. Посмотреть список станций\n 10. Посмотреть список поездов на станции\n" \
      " 11. Список вагонов у поезда\n 12. Занять место/объем в вагоне\n 0. Выйти из меню\n\n")
      printf('Введите номер операции: ')
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
      when 11
        show_wagons_for_train
      when 12
        occupate
      end
    end
  end

  private

  attr_accessor :stations, :routs, :wagons, :trains

  def show_stations
    puts('Список всех станций:')
    stations.each_with_index { |station, i| puts "#{i + 1}. #{station.name}" }
  end

  def show_trains
    puts('Список всех поездов:')
    trains.each_with_index { |train, i| puts "#{i + 1}. #{train.number}" }
  end

  def show_wagons
    puts('Список всех вагонов:')
    wagons.each { |wagon| puts "#{wagon.number}. #{wagon.type}" }
  end

  def show_routs
    routs.each_with_index do |route, i|
      puts("Маршрут №#{i + 1}:")
      route.show_route
    end
  end

  def show_trains_at_staion
    show_stations
    printf('Введите номер станции: ')
    s = gets.to_i
    puts('Список поездов на станции:')
    stations[s - 1].trains_iterator { |x| puts("номер: #{x.number}, тип: #{x.type}, кол-во вагонов: #{x.wagons.size}") }
  end

  def show_wagons_for_train
    show_trains
    printf('Введите номер поезда по списку: ')
    i = gets.to_i
    train = trains[i - 1]
    puts('Список вагонов поезда:')
    case train.type
    when 'грузовой'
      train.wagons_iterator do |x|
        puts("номер: #{x.number}, тип: #{x.type}, кол-во свободного объема: #{x.free_volume}," \
        " кол-во занятого объема: #{x.occupied_volume}")
      end
    when 'пассажирский'
      train.wagons_iterator do |x|
        puts("номер: #{x.number}, тип: #{x.type}, кол-во свободных мест: #{x.free_seats}," \
        " кол-во занятых мест: #{x.occupied_seats}")
      end
    end
  end

  def create_station
    printf('Введите название станции: ')
    name = gets
    stations << Station.new(name)
    puts('Станция успешно создана!')
  end

  def create_train
    puts("\n 1. Создать грузовой поезд\n 2. Cоздать пассажирский поезд\n\n")
    printf('Введите номер операции: ')
    n = gets.to_i
    raise 'Invalid operation' if (n < 1) || (n > 2)

    printf('Введите номер поезда: ')
    number = gets.chomp
    case n
    when 1
      trains << CargoTrain.new(number)
    when 2
      trains << PassengerTrain.new(number)
    end
    puts("Поезд №#{number} успешно создан!")
  rescue RuntimeError => e
    puts(e.message)
    retry
  end

  def create_route
    show_stations
    printf('Введите номер начальной станции: ')
    start = gets.to_i
    printf('Введите номер конечной станции: ')
    finish = gets.to_i
    routs << Route.new(stations[start - 1], stations[finish - 1])
    puts('Маршрут успешно создан!')
  end

  def create_wagon
    puts("\n 1. Создать грузовой вагон\n 2. Cоздать пассажирский вагон\n\n")
    printf('Введите номер операции: ')
    n = gets.to_i
    case n
    when 1
      printf('Введите объем: ')
      volume = gets.to_f
      wagons << CargoWagon.new(volume, wagons.size + 1)
    when 2
      printf('Введите кол-во мест: ')
      seats = gets.to_i
      wagons << PassengerWagon.new(seats, wagons.size + 1)
    end
    puts('Вагон успешно создан!')
  end

  def change_route
    show_routs
    printf('Введите номер маршрута для изменения: ')
    r = gets.to_i
    puts("\n 1. Добавить станцию\n 2. Удалить станцию\n\n")
    printf('Введите номер операции: ')
    n = gets.to_i
    show_stations
    printf('Введите номер станции: ')
    s = gets.to_i
    case n
    when 1
      routs[r - 1].add(stations[s - 1])
    when 2
      routs[r - 1].delete(stations[s - 1])
    end
    puts('Маршрут успешно изменен!')
  end

  def change_wagons
    show_trains
    printf('Введите номер поезда по списку: ')
    t = gets.to_i
    puts("\n 1. Добавить вагон\n 2. Отцепить вагон\n\n")
    printf('Введите номер операции: ')
    n = gets.to_i
    show_wagons
    printf('Введите номер вагона: ')
    w = gets.to_i
    case n
    when 1
      trains[t - 1].add(wagons[w - 1])
    when 2
      trains[t - 1].delete(wagons[w - 1])
    end
  end

  def assign_route
    show_trains
    printf('Введите номер поезда по списку: ')
    t = gets.to_i
    show_routs
    printf('Введите номер маршрута: ')
    r = gets.to_i
    trains[t - 1].route = routs[r - 1]
    puts('Маршрут назначен')
  end

  def move_train
    show_trains
    printf('Введите номер поезда по списку: ')
    t = gets.to_i
    puts("\n 1. Переместить поезд вперед\n 2. Переместить поезд назад\n\n")
    printf('Введите номер операции: ')
    n = gets.to_i
    case n
    when 1
      trains[t - 1].move_next
    when 2
      trains[t - 1].move_back
    end
    puts('Поезд перемещен')
  end

  def occupate
    show_wagons
    printf('Введите номер вагона: ')
    i = gets.to_i
    wagon = wagons[i - 1]
    case wagon.type
    when 'грузовой'
      printf('Введите объем: ')
      volume = gets.to_f
      wagon.fill_with(volume)
    when 'пассажирский'
      wagon.take_seat
    end
  end
end
