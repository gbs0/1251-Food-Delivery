require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    load_csv if File.exists?(@csv_file)
    @next_id = @employees.empty? ? 1 : @employees.last.id + 1
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      attributes = {id: row[:id].to_i, username: row[:username], password: row[:password], role: row[:role]}
      employee = Employee.new(attributes)
      @employees << employee
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb', headers: :first_row) do |row|
      row << ["id", "name", "password", "role"]
      @employees.each do |employee|
        row << [employee.id, employee.name, employee.password, employee.role]
      end
    end
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def all
    @employees
  end

  def create(employee)
    employee.id = @next_id
    @next_id += 1
    @employees << employee
    save_csv
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end
end