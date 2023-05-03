class MealView
  def list(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} | $: #{meal.price}"
    end
  end

  def ask_for(string)
    puts "What is the meal #{string}?"
    print "> "
    gets.chomp
  end
end