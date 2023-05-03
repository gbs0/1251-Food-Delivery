class OrderView
  def list(orders)
    orders.each_with_index do |order, index| 
        puts "#{index + 1} - #{order.meal.name} | #{order.customer.name} -> #{order.employee.username}:#{order.employee.role}"
    end
  end

  def ask_for(string)
    puts "What's the #{string}?"
    gets.chomp
  end

  def display(orders)
    orders.each_with_index do |order, index| 
      status = order.delivered? ? "[X]" : "[ ]" 
      puts "#{index + 1} - #{status} #{order.meal.name} | #{order.customer.name} -> #{order.employee.username}:#{order.employee.role}"
    end
  end
end