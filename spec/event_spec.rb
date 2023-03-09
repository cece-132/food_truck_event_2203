require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do 262.5
  before :each do
    @event = Event.new("South Pearl Street Farmers Market")

    @mountain_truck = FoodTruck.new("Rocky Mountain Pies")
    @nom_truck = FoodTruck.new("Ba-Nom-a-Nom")
    @shack_truck = FoodTruck.new("Palisade Peach Shack")

    @peach = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @apple = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @peach_nice_cream = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @banana_nice_cream = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @mountain_truck.stock(@peach, 35)
    @mountain_truck.stock(@apple, 7)

    @nom_truck.stock(@banana_nice_cream, 50)
    @nom_truck.stock(@peach_nice_cream, 25)

    @shack_truck.stock(@peach, 65)
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@event).to be_a(Event)
      expect(@event.name).to be_a String
      expect(@event.food_trucks).to be_a Array
      expect(@event.food_trucks).to be_empty
    end
  end

  before :each do
    @event.add_food_truck(@mountain_truck)
    @event.add_food_truck(@nom_truck)
    @event.add_food_truck(@shack_truck)
  end

  describe '#add_food_truck(truck)' do
    it 'can add food trucks to an event' do
      expect(@event.food_trucks).to eq [@mountain_truck, @nom_truck, @shack_truck]
    end
  end

  describe '#food_truck_names' do
    it 'should return a list of all the food truck names' do
      expect(@event.food_truck_names).to eq ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    end
  end

  describe '#food_trucks_that_sell(item)' do
    it 'return the trucks that sell the item' do
      expect(@event.food_trucks_that_sell(@peach)).to eq [@mountain_truck, @shack_truck]
    end
  end

end
