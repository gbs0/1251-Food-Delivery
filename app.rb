# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb
require 'csv'
require_relative 'router'
require_relative 'app/repositories/meal_repository'
require_relative 'app/controllers/meals_controller'


require_relative 'app/repositories/customer_repository'
require_relative 'app/controllers/customers_controller'

require_relative 'app/controllers/sessions_controller'
require_relative 'app/repositories/employee_repository'

customer_repository = CustomerRepository.new('data/customer.csv')
customers_controller = CustomersController.new(customer_repository)

meal_repository = MealRepository.new('data/meals.csv')
meals_controller = MealsController.new(meal_repository)

employee_repository = EmployeeRepository.new('data/employee.csv')
sessions_controller = SessionsController.new(employee_repository)

router = Router.new(meals_controller, customers_controller, sessions_controller)
router.start