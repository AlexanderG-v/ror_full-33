# frozen_string_literal: true

class TextUserInterface
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
            'Введите 9, что бы отправить поезд по маршруту вперед/назад.',
            'Введите 10, что бы просмотреть список станций и список поездов на станциях.',
            'Введите 0, что бы выйти из программы.']
    menu.each { |item| puts item.to_s }
    puts '=========================================='
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
    when 9 then move_train
    when 10 then show_list_stations_and_trains_at_station
    when 0 then exit
    else
      puts 'Вы ввели неверный № команды! Пожалуйста, введите № команды из списка.'
      menu
    end
  end

  private # - вызов осуществляется общедоступным методом класса

  def create_station
    print 'Введите название станции: '

    name_station = gets.chomp

    if @stations.find { |station| station.name == name_station }
      puts 'Станция с таким названием уже существует!'
      create_station
    else
      @stations << Station.new(name_station)
      puts "Вы создали станцию \"#{name_station.capitalize}\"!"
      puts '=========================================='
      menu
    end
  end

  def create_train
    print 'Введите № поезда: '
    num_train = gets.chomp.to_i

    if @trains.find { |train| train.number == num_train }
      puts 'Поезд с таким номером уже существует!'
      create_train
    else
      print 'Выбирете тип поезда, где 1 - это пассажирский поезд, а 2 - это грузовой поезд: '
      type_train = gets.to_i
      case type_train
      when 1
        @trains << PassengerTrain.new(num_train)
        puts "Вы создали пассажирский поезд № #{num_train}!"
        puts '===================================='
        menu
      when 2
        @trains << CargoTrain.new(num_train)
        puts "Вы создали грузовой поезд № #{num_train}!"
        puts '===================================='
        menu
      else
        puts 'Вы вводите неправильный тип поезда! Попробуйте еще раз.'
        create_train
      end

    end
  end

  def create_route
    if @stations.size >= 2
      puts 'Для создания маршрута необходимо не менее двух станций!'
      stations_list
      puts 'Пожалуйста, введите порядковый номер начальной станции из списка'
      first_station = gets.chomp.to_i
      puts 'Теперь введите порядковый номер конечной станции.'
      last_station = gets.chomp.to_i
      @route << Route.new(stations[first_station - 1], stations[last_station - 1])
      puts 'Вы создали маршрут!'
      puts '===================================='
      menu
    else
      puts 'Недостаточно станций для создания маршрутa! Пожалуйста, создайте станцию.'
      create_station
    end
  end

  def add_station_in_route
    if @route.empty?
      puts 'Маршрутов не найдено! Сначала создайте маршрут!'
      create_route
    else
      puts 'Выберите порядковый номер маршрута, что бы добавить станцию:'
      route_list
      index_route = gets.chomp.to_i
      if index_route > @route.size
        puts 'Вы вводите неправильный порядковый номер маршрута! Попробуйте еще раз.'
        add_station_in_route
      else
        puts 'Выберете порядковый номер станции, которую необходимо добавить в мартшрут:'
        stations_list
        index_station = gets.chomp.to_i
        station = @stations[index_station - 1]
        if index_station > @stations.size
          puts 'Вы вводите неправильный порядковый номер станции! Попробуйте еще раз.'
          add_station_in_route
        else
          @route[index_route - 1].add_stations(station)
          puts 'Вы добавили станцию к маршруту!'
          puts '===================================='
          menu
        end
      end
    end
  end

  def remove_station_frome_route
    if @route.empty?
      puts 'Маршрутов не найдено!'
      menu
      item_selection
    else
      puts 'Выберите порядковый номер маршрута, что бы удалить станцию:'
      route_list
      index_route = gets.chomp.to_i
      route = @route[index_route - 1]
      if index_route > @route.size
        puts 'Вы вводите неправильный порядковый номер маршрута! Попробуйте еще раз.'
        remove_station_frome_route
      else
        puts 'Выберете порядковый номер станции, которую необходимо удалить из мартшрута.'
        route.show_stations
        index = gets.to_i
        station = route.stations[index - 1]
        if index > route.stations.size
          puts 'Вы вводите неправильный порядковый номер станции! Попробуйте еще раз.'
          remove_station_frome_route
        else
          route.delete_station(station)
          puts 'Вы удалили станцию из маршрута!'
          puts '===================================='
          menu
        end
      end
    end
  end

  def add_wagons_to_train
    if @trains.empty?
      puts 'Поездов не найдено! Сначала создайте поезд.'
      create_train
    else
      puts 'Выбирете порядковый номер поезда, к которому прицепить вагон:'
      trains_list
      index_train = gets.to_i
      if index_train > @trains.size
        puts 'Вы вводите неправильный порядковый номер поезда! Попробуйте еще раз.'
        add_wagons_to_train
      else
        case @trains[index_train - 1].type_train
        when 'passenger'
          @trains[index_train - 1].add_wagons(PassengerWagons.new)
          puts 'К поезду прицеплен вагон!'
          puts '===================================='
          menu
        when 'cargo'
          @trains[index_train - 1].add_wagons(CargoWagons.new)
          puts 'К поезду прицеплен вагон!'
          puts '===================================='
          menu
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
      index_train = gets.to_i
      if @trains[index_train - 1].wagons.empty?
        puts 'У поезда отсутствуют вагоны! Выберите другой поезд.'
        remove_wagons_from_train
      else
        @trains[index_train - 1].wagons.pop
        puts 'У поезда удален вагон!'
        puts '===================================='
        menu
      end
    end
  end

  def add_train_route
    if @trains.empty?
      puts puts 'Поездов не найдено! Сначала созайте поезд.'
      create_train
    end
    if @route.empty?
      puts 'Маршрутов не найдено! Сначала создайте маршрут!'
      create_route
    end

    puts 'Выбирете порядковый номер поезда, для прикрепления его к маршруту:'
    trains_list
    index_train = gets.chomp.to_i
    train = @trains[index_train - 1]
    if index_train > @trains.size
      puts 'Вы вводите неправильный порядковый номер поезда! Попробуйте еще раз.'
      add_train_route
    else
      puts 'Выберите порядковый номер маршрута, что бы назначить поезд:'
      route_list
      index_route = gets.chomp.to_i
      route = @route[index_route - 1]
      if index_route > @route.size
        puts 'Вы вводите неправильный порядковый номер маршрута! Попробуйте еще раз.'
        add_train_route
      else
        train.add_route(route)
        puts 'Вы назначили поезд маршруту!'
        puts '===================================='
        menu
      end
    end
  end

  def move_train
    puts 'Выбирете порядковый номер поезда, для отправки:'
    trains_list
    index_train = gets.chomp.to_i
    train = @trains[index_train - 1]
    puts 'Выберите направление, где 1 - это вперед, а 2 - это назад.'
    choice = gets.chomp.to_i
    case choice
    when 1 then train.go_forward
                puts '===================================='
                menu
    when 2 then train.go_back
                puts '===================================='
                menu
    else
      puts 'Нет такого направения! Пожалуйста, повторите попытку.'
      move_train
    end
  end

  def show_list_stations_and_trains_at_station
    puts 'Выберите порядковый номер станции для просмотра дополнительной информации:'
    stations_list
    index_station = gets.chomp.to_i
    station = @stations[index_station - 1]
    if station.trains.empty?
      puts 'На этой станции нет поездов!'
    else
      puts 'На этой станции находится:'
      station.trains.each_with_index do |train, index|
        puts "#{index + 1}. Поезд № #{train.number}, тип поезда: #{train.type_train}, прицеплено вагонов: #{train.wagons.size}."
      end
    end
    menu
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

  def route_list
    route.each_with_index do |route, index|
      puts "#{index + 1}. Маршрут: #{route.name * ' - '}."
    end
  end
end
