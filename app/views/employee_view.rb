class EmployeeView
  def list(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username} | 📍: #{employee.role}"
    end
  end
end