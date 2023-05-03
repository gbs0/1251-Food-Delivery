class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
  end

  def start
    employee = @sessions_controller.sign_in
    loop do
      if employee.manager?
        user_choice = print_menu
        dispatch_manager(user_choice)
      else
        rider_choice = print_rider_menu
        dispatch_rider(rider_choice, employee)
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
    when 5
        @orders_controller.add
    when 6
        @orders_controller.list
    when 9
        exit
    else
        puts "Invalid Option!"
    end  
  end

  def dispatch_rider(rider_choice, employee)
    case rider_choice
    when 1
      @orders_controller.list_undelivered_orders
    when 2
      @orders_controller.mark_order_as_delivered(employee)
    when 9
      exit
    else
      puts "Invalid Option! Try again"
    end
  end

  def print_menu
    puts "------------ MENU ------------"  
    puts "Choose an action to start with:"
    puts "1 - Create new Meal"
    puts "2 - List Meal(s)"
    puts "--------- CUSTOMER -----------"
    puts "3 - Create new Customer"
    puts "4 - List all Customer(s)"
    puts "--------- CUSTOMER -----------"
    puts "5 - Create new Order"
    puts "6 - List Order(s)"
    puts "9 - Quit"
    print "> "
    gets.chomp.to_i
  end

  def print_rider_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "1. - List all Undelivered Orders"
    puts "2. - Mark Order as Delivered!"
    puts "9. - Quit!"
    print "> "
    gets.chomp.to_i
  end
end