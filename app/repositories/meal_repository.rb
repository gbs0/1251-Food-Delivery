require_relative '../models/meal'
# Representação visual da lista de pratos: @meals
#     [
#     <# Meal:0x000044 @id=1, @name="Miojo", @price=7>, |meal|
#     <# Meal:0x000045 @id=2, @name="Bolo De Cenoura", @price=7>, |meal|
#     <# Meal:0x000046 @id=3, @name="Coxinha", @price=7>
#     <# Meal:0x000046 @id=4, @name="Frango Assado", @price=25>
#     ]

class MealRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    load_csv if File.exists?(@csv_file)
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end
  
  def create(meal)
    # meal = <# Meal:0x000046 @id=nil, @name="Frango Assado", @price=25>
    meal.id = @next_id
    # 1. Colocar o objeto meal, dentro da lista @meals
    @meals << meal
    # 2. Incrementar o @next_id em + 1
    @next_id += 1
    # 3. Salvar a lista no CSV
    save_csv 
  end

  def all
    @meals
  end

  def find(id) # 3
    # @meals.select { |meal| meal.id == id }.first
    # => [<# Meal:0x000046 @id=3, @name="Coxinha", @price=7>]
    @meals.find { |meal| meal.id == id }
    # => <# Meal:0x000046 @id=3, @name="Coxinha", @price=7>
  end

  def save_csv
    CSV.open(@csv_file, 'wb', headers: :first_row) do |file|
      file << ["id", "name", "price"]
      @meals.each do |meal|
        file << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      attributes = { id: row[:id].to_i, name: row[:name], price: row[:price].to_i }
      meal = Meal.new(attributes)
      @meals << meal
    end
  end
end