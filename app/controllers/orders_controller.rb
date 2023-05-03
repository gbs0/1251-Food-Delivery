require 'pry'
require_relative '../views/order_view'
require_relative '../views/meal_view'
require_relative '../views/customer_view'
require_relative '../views/employee_view'

class OrdersController
  def initialize(order_repository, meal_repository, customer_repository, employee_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @view = OrderView.new
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @employee_view = EmployeeView.new
  end

  def add
    # 1. Qual é o prato a ser adicionado 
    meals = @meal_repository.all
    @meal_view.list(meals)
    meal_index = @view.ask_for("meals index").to_i

    # 2. Qual é o cliente a ser enviado
    customers = @customer_repository.all
    @customer_view.list(customers)
    customer_index = @view.ask_for("customers index").to_i

    # 3. Qual é o funcionário que irá enviar
    employees = @employee_repository.all
    @employee_view.list(employees)
    employee_index = @view.ask_for("employees index").to_i


    order = Order.new(meal: meals[meal_index - 1],
      customer: customers[customer_index - 1],
      employee: employees[employee_index - 1]
    )
    @order_repository.create(order)
  end

  def list
    orders = @order_repository.all
    @view.list(orders)
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @view.display(undelivered_orders)
  end

  def mark_order_as_delivered(employee)
    # 1. Mostrar qual o pedido a ser marcado como entregue
    orders = @order_repository.undelivered_orders
    @view.display(orders)

    # 2. Perguntar p/ o user, qual o pedido
    order_index = @view.ask_for("order index").to_i

    # 3. Buscar na lista de pedidos, o pedido que o user escolheu
    order = orders[order_index - 1]

    # 4. Marcamos o pedido como entregue!
    order.deliver!

    # 5. Salvar a mudança no CSV
    @order_repository.save_csv
  end
end