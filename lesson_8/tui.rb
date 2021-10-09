# frozen_string_literal: true

class TextUserInterface
  USER_INPUT = {
    1 => :create_station, 2 => :create_train, 3 => :create_route, 4 => :add_station_in_route,
    5 => :remove_station_frome_route, 6 => :add_train_route, 7 => :add_wagons_to_train,
    8 => :take_seat_or_volume, 9 => :remove_wagons_from_train, 10 => :move_train,
    11 => :show_list_stations_and_trains_at_station, 12 => :show_list_wagons, 0 => :exit
  }.freeze

  attr_accessor :trains, :stations, :route, :wagons

  def initialize
    @stations = []
    @trains = []
    @route = []
  end

  def shows_the_menu
    puts '===================================='
    menu = [
      'Введите 1, что бы создать станцию.',
      'Введите 2, что бы создать поезд.',
      'Введите 3, что бы создать маршрут.',
      'Введите 4, что бы добавить станцию в маршрут.',
      'Введите 5, что бы удалить станцию из маршрута.',
      'Введите 6, что бы назначить маршрут поезду.',
      'Введите 7, что бы прицепить вагоны к поезду.',
      'Ввудите 8, что бы занять место/объем в вагоне.',
      'Введите 9, что бы отцепить вагоны от поезда.',
      'Введите 10, что бы отправить поезд по маршруту вперед/назад.',
      'Введите 11, что бы просмотреть список станций и список поездов на станциях.',
      'Введите 12, что бы просмотреть список вагонов у поезда.',
      'Введите 0, что бы выйти из программы.'
    ]
    menu.each { |item| puts item.to_s }
    puts '===================================='
  end

  def item_selection
    shows_the_menu
    print 'Введите № команды: '
    input = gets.to_i
    USER_INPUT[input] ? send(USER_INPUT[input]) : back_to_menu
  end

  def back_to_menu
    puts 'Вы ввели неверный № команды! Пожалуйста, введите № команды из списка.'
    item_selection
  end

  private

  def create_station
    print 'Введите название станции: '
    name_station = gets.chomp
    if @stations.find { |station| station.name == name_station }
      puts 'Станция с таким названием уже существует!'
      create_station
    else
      @stations << Station.new(name_station)
      puts "Вы создали станцию \"#{name_station}\"!"
      item_selection
    end
  rescue StandardError
    puts 'У станции должно быть название!'
    retry
  end

  def create_train
    print 'Введите № поезда: '
    num_train = gets.chomp
    if @trains.find { |train| train.number == num_train }
      puts 'Поезд с таким номером уже существует! Попробуйте еще раз.'
      create_train
    else
      print 'Выбирете тип поезда, где 1 - это пассажирский поезд, а 2 - это грузовой поезд: '
      type_train = gets.to_i
      case type_train
      when 1
        @trains << PassengerTrain.new(num_train)
        puts "Вы создали пассажирский поезд № #{num_train}!"
        item_selection
      when 2
        @trains << CargoTrain.new(num_train)
        puts "Вы создали грузовой поезд № #{num_train}!"
        item_selection
      else
        puts 'Вы вводите неправильный тип поезда! Попробуйте еще раз.'
        create_train
      end
    end
  rescue StandardError
    puts 'Вы ввели некорректный № поезда! Попробуйте еще раз. (Пример формата №: "Ф12-12").'
    retry
  end

  def create_route
    raise if @stations.size < 2

    puts 'Для создания маршрута необходимо не менее двух станций!'
    stations_list
    puts 'Пожалуйста, введите порядковый номер начальной станции из списка'
    first_station = gets.chomp.to_i
    puts 'Теперь введите порядковый номер конечной станции.'
    last_station = gets.chomp.to_i
    @route << Route.new(stations[first_station - 1], stations[last_station - 1])
    puts "Вы создали маршрут \"#{route.last.name.join(' - ')}\"!"
    item_selection
  rescue StandardError
    puts 'Недостаточно станций для создания маршрутa! Пожалуйста, создайте станцию.'
    create_station
  end

  def add_station_in_route
    if @route.empty?
      puts 'Маршрутов не найдено! Сначала создайте маршрут!'
      create_route
    else
      puts 'Выберите порядковый номер маршрута, что бы добавить станцию:'
      route_list
      index_route = gets.chomp.to_i
      route = @route[index_route - 1]
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
          route.add_stations(station)
          puts "К маршруту \"#{route.name.join(' - ')}\" добавлена станция \"#{station.name}\"!"
          item_selection
        end
      end
    end
  end

  def remove_station_frome_route
    if @route.empty?
      puts 'Маршрутов не найдено!'
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
          puts "Из маршрута \"#{route.name.join(' - ')}\" удалена станция \"#{station.name}!"
          item_selection
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
      train = @trains[index_train - 1]
      if index_train > @trains.size
        puts 'Вы вводите неправильный порядковый номер поезда! Попробуйте еще раз.'
        add_wagons_to_train
      else
        case train.type_train
        when 'passenger'
          puts 'Введите количесто мест вагона:'
          count = gets.chomp.to_i
          train.add_wagons(PassengerWagons.new(count))
          puts "К поезду № #{train.number} прицеплен вагон!"
          item_selection
        when 'cargo'
          puts 'Введите общий объем вагона:'
          count = gets.chomp.to_i
          train.add_wagons(CargoWagons.new(count))
          puts "К поезду № #{train.number} прицеплен вагон!"
          item_selection
        end
      end
    end
  end

  def take_seat_or_volume
    trains_list
    puts 'Выбирете порядковый номер поезда:'
    index_train = gets.chomp.to_i
    train = @trains[index_train - 1]
    if train.wagons.empty?
      puts "У поезда № #{train.number} отсутствуют вагоны! Выберите другой поезд."
      show_list_wagons
    else
      case train.type_train
      when 'passenger'
        train.wagons.each_with_index do |wagon, index|
          (puts "Вагон № #{index + 1}, кол-во свободных мест: #{wagon.free_seats},
            занятых метст: #{wagon.seats_taken}."
          )
        end
        puts 'Выбирете № вагона'
        index_wagon = gets.chomp.to_i
        wagon = train.wagons[index_wagon - 1]
        wagon.add_seat
        puts 'Вы заняли одно свободное место в вагоне!'
        item_selection
      when 'cargo'
        train.wagons.each_with_index do |wagon, index|
          (puts "Вагон № #{index + 1}, свободный объем вагона: #{wagon.free_volume},
             кол-во занятого объема: #{wagon.filled_volume}."
          )
        end
        puts 'Выбирете № вагона'
        index_wagon = gets.chomp.to_i
        wagon = train.wagons[index_wagon - 1]
        puts 'Введите объем, который необходимо загрузить.'
        load = gets.chomp.to_i
        wagon.load_volume(load)
        puts "В вагон загружено #{load} объема!"
        item_selection
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
      train = @trains[index_train - 1]
      if train.wagons.empty?
        puts "У поезда № #{train.number} отсутствуют вагоны! Выберите другой поезд."
        remove_wagons_from_train
      else
        train.wagons.pop
        puts "У поезда № #{train.number} удален вагон!"
        item_selection
      end
    end
  end

  def add_train_route
    if @trains.empty?
      puts puts 'Поездов не найдено! Сначала созайте поезд.'
      create_train
    elsif @route.empty?
      puts 'Маршрутов не найдено! Сначала создайте маршрут!'
      create_route
    else
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
          puts "Поезд № #{train.number} следует по маршруту \"#{route.name.join(' - ')}\"!"
          item_selection
        end
      end
    end
  end

  def move_train
    puts 'Выбирете порядковый номер поезда, для отправки:'
    trains_list
    index_train = gets.chomp.to_i
    train = @trains[index_train - 1]
    puts "Поезд № #{train.number} стоит на станции \"#{train.current_station.name}\"."
    puts 'Выберите направление, где 1 - это вперед, а 2 - это назад.'
    choice = gets.chomp.to_i
    case choice
    when 1
      train.go_forward
      puts "Поезд № #{train.number} отправился на станцию \"#{train.current_station.name}\"."
      item_selection
    when 2
      train.go_back
      puts "Поезд № #{train.number} отправился на станцию \"#{train.current_station.name}\"."
      item_selection
    else
      puts 'Нет такого направения! Пожалуйста, повторите попытку.'
      move_train
    end
  end

  def show_list_wagons
    trains_list
    puts 'Выбирете порядковый номер поезда:'
    index_train = gets.chomp.to_i
    train = @trains[index_train - 1]
    if train.wagons.empty?
      puts "У поезда № #{train.number} отсутствуют вагоны!"
      item_selection
    else
      case train.type_train
      when 'passenger'
        train.wagons.each_with_index do |wagon, index|
          (puts "Вагон № #{index + 1}, тип вагона: \"#{wagon.type_wagon}\", кол-во свободных мест:
            #{wagon.free_seats}, занятых метст: #{wagon.seats_taken}."
          )
          item_selection
        end
      when 'cargo'
        train.wagons.each_with_index do |wagon, index|
          (puts "Вагон № #{index + 1}, тип вагона: \"#{wagon.type_wagon}\", свободный объем вагона:
             #{wagon.free_volume}, кол-во занятого объема: #{wagon.filled_volume}."
          )
          item_selection
        end
      end
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
        (puts "#{index + 1}. Поезд № #{train.number}, тип поезда: #{train.type_train},
          прицеплено вагонов: #{train.wagons.size}."
        )
      end
    end
    item_selection
  end

  def stations_list
    stations.each_with_index do |station, index|
      puts "#{index + 1}. станция \"#{station.name.capitalize}\"."
    end
  end

  def trains_list
    trains.each_with_index do |train, index|
      (puts "#{index + 1}. Поезд № #{train.number}, тип поезда: #{train.type_train},
        прицеплено вагонов: #{train.wagons.size}."
      )
    end
  end

  def route_list
    route.each_with_index do |route, index|
      puts "#{index + 1}. Маршрут \"#{route.name.join(' - ')}\"."
    end
  end
end
