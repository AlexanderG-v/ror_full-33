# frozen_string_literal: true

require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'cargo_wagons'
require_relative 'passenger_wagons'
require_relative 'cargo_train'
require_relative 'passenger_train'

puts 'Добро пожаловать на пульт управления поездами!'

class Main
  attr_accessor :trains, :stations, :route, :wagons

  def initialize
    @stations = []
    @trains = []
    @route = []
  end

  def menu
    menu = ['Введите 1, что бы создать станцию.',
            'Введите 2, что бы создать поезд.',
            'Введите 3, что бы создать маршрут.',
            'Введите 4, что бы добавить станцию в маршрут.',
            'Введите 5, что бы удалить станцию из маршрута.',
            'Введите 6, что бы назначить маршрут поезду.',
            'Введите 7, что бы прицепить вагоны к поезду.',
            'Введите 8, что бы отцепить вагоны от поезда.',
            'Введите 9, что бы отправить поезд по маршруту вперед.',
            'Введите 10, что бы отправить поезд по маршруту назад.',
            'Введите 11, что бы просмотреть список станций и список поездов на станциях.',
            'Введите 0, что бы выйти из программы.']
    menu.each { |item| puts item.to_s }
  end

  def item_selection
    print 'Введите № команды: '
    user_input = gets.to_i

    case user_input
    when 1 then create_station
    when 2 then create_train
    when 3 then create_route
    when 4 then add_station_in_route
    when 5 then remove_station_frome_route
    when 6 then add_train_route
    when 7 then add_wagons_to_train
    when 8 then remove_wagons_from_train
    when 9 then train_go_forvard
    when 10 then train_go_back
    when 11 then show_list_stations_and_trains_at_station
    when 0 then exit
    else
      puts 'Вы ввели неверный № команды! Пожалуйста, введите № команды из списка.'
      item_selection
    end
  end

  def create_station
    print 'Введите название станции: '
    name_station = gets.chomp

    if @stations.find { |station| station.name == name_station }
      puts 'Станция с таким названием уже существует!'
    else
      @stations << Station.new(name_station)
      puts "Вы создали станцию \"#{name_station.capitalize}\"!"
      # item_selection # ?????
    end
  end

  def create_train
    print 'Введите № поезда: '
    num_train = gets.chomp.to_i

    if @trains.find { |train| train.number == num_train }
      puts 'Поезд с таким номером уже существует!'

    else
      print 'Выбирете тип поезда, где 1 - это пассажирский поезд, а 2 - это грузовой поезд: '
      type_train = gets.to_i
      case type_train
      when 1
        @trains << PassengerTrain.new(num_train)
        puts "Вы создали пассажирский поезд № #{num_train}!"
      when 2
        @trains << CargoTrain.new(num_train)
        puts "Вы создали грузовой поезд № #{num_train}!"
      else
        puts 'Вы вводите неправильный тип поезда! Попробуйте еще раз.'
        create_train
      end
      # item_selection # ?????
    end
  end

  # Метод создания маршрута. нужна проверка наличия двух станций начальной и конечной

  def create_route
    if stations.size >= 2
      puts 'Для создания маршрута необходимо не менее двух станций!'
      stations_list
      puts 'Пожалуйста, введите порядковый номер начальной станции из списка'
      first_station = gets.chomp.to_i - 1
      puts 'Теперь введите порядковый номер конечной станции.'
      last_station = gets.chomp.to_i - 1
      @route << Route.new(stations[first_station], stations[last_station])
      @route.each do | station|
      puts "Вы создали маршрут"
      end
    
    else
      puts 'Недостаточно станций для создания маршруты! Пожалуйста, создайте станцию.'
      create_station
    end

  end

  def add_wagons_to_train
    if @trains.empty?
      puts 'Поездов не найдено! Сначала создайте поезд.'
      create_train
    else
      puts 'Выбирете порядковый номер поезда, к которому прицепить вагон:'
      trains_list
      index_train = gets.to_i - 1
      if index_train > @trains.size - 1
        puts 'Вы вводите неправильный порядковый номер поезда! Попробуйте еще раз.'
        add_wagons_to_train
      else
        case @trains[index_train].type_train
        when 'passenger'
          @trains[index_train].add_wagons(PassengerWagons.new)
          puts 'К поезду прицеплен вагон!'
        when 'cargo'
          @trains[index_train].add_wagons(CargoWagons.new)
          puts 'К поезду прицеплен вагон!'
        end
      end
    end
  end

  def remove_wagons_from_train
    if @trains.empty?
      puts 'Поездов не найдено! Сначала созайте поезд.'
      create_train
    else
      puts 'Выбирете порядковый номер поезда, у которого необходимо отцепить вагон:'
      trains_list
      index_train = gets.to_i - 1
      if @trains[index_train].wagons.empty?
        puts 'У поезда отсутствуют вагоны! Выберите другой поезд.'
        trains_list
      else
        @trains[index_train].wagons.pop
        puts 'У поезда удален вагон!'
      end
    end
  end

  def stations_list
    stations.each_with_index do |station, index|
      puts "#{index + 1}. станция \"#{station.name.capitalize}\"."
    end
  end

  def trains_list
    trains.each_with_index do |train, index|
      puts "#{index + 1}. Поезд № #{train.number}, тип поезда: #{train.type_train}, прицеплено вагонов: #{train.wagons.size}."
    end
  end

  def seed
    @stations << Station.new('Стрешнево')
    @stations << Station.new('Красногорск')
    @stations << Station.new('Нахабино')
    @trains << PassengerTrain.new(111)
    @trains << CargoTrain.new(777)
  end
end

# main = Main.new
# main.menu
# main.item_selection
