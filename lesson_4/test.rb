# frozen_string_literal: true

class Main
  attr_accessor :trains, :stations, :route, :wagons

  def initialize
    @stations = []
    @trains = []
    @route = []
    @wagons = []
  end

  def start
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
    when 8 then remoove_wagons_from_train
    when 9 then train_go_forvard
    when 10 then train_go_back
    when 11 then show_list_stations_and_trains_at_station
    when 0 then exit
    else
      puts 'Вы ввели неверный № команды! Пожалуйста, введите № команды из списка.'
      item_selection
    end
  end

  # Метод создания станции. При создании указывается название станции
  def create_station
    print 'Введите название станции: '
    station = gets.chomp
    @stations << Station.new(station)
    puts "Вы создали станцию #{station}!"
    item_selection
  end

  # Метод созания поезда. При создании поезда указывается номер и тип

  def create_train
    print 'Введите № поезда: '
    num_train = gets.chomp.to_i
    
    puts 'Выбирете тип поезда: пассажирский или грузовой?'
    type_train = gets

    @trains << CargoTrain(num_train) if type_train == 'пассажирский'
  end




end
