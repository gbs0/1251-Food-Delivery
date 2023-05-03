require_relative '../views/meal_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealView.new
  end

  def add
    # 1. Perguntamos o nome do prato
    name = @view.ask_for("name")
    # 2. Perguntamos o preço do prato
    price = @view.ask_for("price").to_i
    # 3. Criamos uma instância que representa a classe Meal
    meal = Meal.new(name: name, price: price)
    # 4. Salvamos o prato no repositório
    @meal_repository.create(meal)
  end

  def list
    meals = @meal_repository.all
    @view.list(meals)
  end
end