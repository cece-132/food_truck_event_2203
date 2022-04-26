require 'pry'

class Event
  attr_reader :name, :food_trucks
  def initialize(name)
      @name = name
      @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    truck_name = []
    @food_trucks.each do |truck|
      truck_name << truck.name
    end
    truck_name
  end

  def food_trucks_that_sell(item)
    @food_trucks.map do |truck|
        truck.inventory.each do |ito|
          @trucks_with_items = Array.new(0)
          ito == item
          @trucks_with_items << truck
        end
      @trucks_with_items
    end
  end
end
