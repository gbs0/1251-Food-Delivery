class CustomerView
    def list(customers)
      customers.each_with_index do |customer, index|
        puts "#{index + 1} - #{customer.name} | 📍: #{customer.address}"
      end
    end
  
    def ask_for(string)
      puts "What is the customer #{string}?"
      print "> "
      gets.chomp
    end
  end