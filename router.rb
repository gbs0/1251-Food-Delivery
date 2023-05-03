class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
  end

  def start
    employee = @sessions_controller.sign_in
    loop do
      if employee.manager?
        user_choice = print_menu
        dispatch_manager(user_choice)
      else
        rider_choice = print_rider_menu
        dispatch_rider(rider_choice)
      end
    end
  end

  def dispatch_manager(user_choice)
    case user_choice
    when 1
      @meals_controller.add
    when 2
      @meals_controller.list
    when 3
        @customers_controller.add
    when 4
        @customers_controller.list
    when 9
        exit
    else
        puts "Invalid Option!"
    end  
  end

  def dispatch_rider(rider_choice)
    # TODO
    puts "Dispath rider action... #{rider_choice}" 
  end

  def print_menu
    puts "------------ MENU ------------"  
    puts "Choose an action to start with:"
    puts "1 - Create new Meal"
    puts "2 - List Meal(s)"
    puts "--------- CUSTOMER -----------"
    puts "3 - Create new Customer"
    puts "4 - List all Customer(s)"
    puts "9 - Quit"
    print "> "
    gets.chomp.to_i
  end

  def print_rider_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "TO-DO: List all Rider actions!"
    print "> "
    gets.chomp.to_i
  end
end