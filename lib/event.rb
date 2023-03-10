require 'pry'
require 'date'

class Event
  attr_reader :name, :food_trucks, :created_on
  def initialize(name)
      @name = name
      @food_trucks = []
      @created_on = DateTime.now
  end

  def date
    @created_on.strftime('%d/%m/%y')
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.map do |truck|
        truck if truck.inventory.include?(item)
    end.compact
  end

  def sorted_item_list
   @food_trucks.map do |truck|
      truck.inventory.keys
    end.flatten.uniq
  end

  def overstocked_items
    inventory_hash.map do |item, info|
      if info[:quantity] > 50 && info[:truck_count] >= 2
        item
      end
    end.compact
  end

  def inventory_hash
    hash = {}
    @food_trucks.each do |truck|
      truck.inventory.each do |item, quantity|
        if hash[item]
          hash[item][:quantity] += quantity
          hash[item][:truck_count] += 1
        else
          hash[item] = {quantity: quantity, truck_count: 1}
        end
      end
    end
    hash
  end

  def total_inventory
    hash = {}
    @food_trucks.each do |truck|
      truck.inventory.each do |item, quantity|
        if hash[item]
          hash[item][:quantity] += quantity
          hash[item][:food_trucks] << truck 
        else
          hash[item] = {quantity: quantity, food_trucks: [truck]}
        end
      end
    end
    hash
  end

  def sell(item, quantity)
    found = inventory_hash.find { |inventory, info| inventory == item}
    if found[1][:quantity] > quantity
      reduce_inventory(item, quantity)
      return true
    else
      return false
    end
  end

  def reduce_inventory(item, quantity)
    count = quantity
    food_trucks_that_sell(item).each do |truck|
      truck.inventory.each do |inventory, amount| 
        if inventory == item
          truck.inventory[inventory] = amount -= count
          if truck.inventory[inventory].negative?
            truck.inventory[inventory] = 0
            reduce_inventory(inventory, (amount -= count))
          end
        end
      end
    end
  end

end
