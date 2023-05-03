require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    load_csv if File.exists?(@csv_file)
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end

  def create(customer)
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end
  
  def all
    @customers
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      attributes = {id: row[:id].to_i, name: row[:name], address: row[:address]}
      customer = Customer.new(attributes)
      @customers << customer
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb', headers: :first_row) do |row|
      row << ["id", "name", "address"]
      @customers.each do |customer|
        row << [customer.id, customer.name, customer.address]
      end
    end
  end
end