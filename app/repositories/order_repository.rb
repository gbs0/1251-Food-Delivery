require_relative '../models/order'

class OrderRepository
  def initialize(csv_file, meal_repository, customer_repository, employee_repository)
    @csv_file = csv_file
    @orders = []
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    load_csv if File.exist?(@csv_file)
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
        meal = @meal_repository.find(row[:meal_id].to_i)
        customer = @customer_repository.find(row[:customer_id].to_i)
        employee = @employee_repository.find(row[:employee_id].to_i)
        delivered = row[:delivered] == "true"
        attributes = {id: row[:id].to_i, meal: meal, customer: customer, employee: employee, delivered: delivered }
        @orders << Order.new(attributes)
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb', headers: :first_row) do |file|
      file << %w[id delivered meal_id customer_id employee_id]
      @orders.each do |order|
        file << [order.id, order.delivered, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end

  def undelivered_orders
    @orders.select { |order| order.delivered? == false }
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def all
    @orders
  end

  def find(id)
    @orders.find { |order| order.id == id }
  end
end