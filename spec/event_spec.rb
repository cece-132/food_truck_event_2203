require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do 
  before :each do
    @event = Event.new("South Pearl Street Farmers Market")

    @mountain_truck = FoodTruck.new("Rocky Mountain Pies")
    @nom_truck = FoodTruck.new("Ba-Nom-a-Nom")
    @shack_truck = FoodTruck.new("Palisade Peach Shack")

    @peach = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @apple = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @peach_nice_cream = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @banana_nice_cream = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@event).to be_a(Event)
      expect(@event.name).to be_a String
      expect(@event.food_trucks).to be_a Array
      expect(@event.food_trucks).to be_empty
    end
  end

  describe '#add_food_truck(truck)' do
    before :each do
      @event.add_food_truck(@mountain_truck)
      @event.add_food_truck(@nom_truck)
      @event.add_food_truck(@shack_truck)
    end

    it 'can add food trucks to an event' do
      expect(@event.food_trucks).to eq [@mountain_truck, @nom_truck, @shack_truck]
    end
  end

  describe '#food_truck_names' do
    before :each do
      @event.add_food_truck(@mountain_truck)
      @event.add_food_truck(@nom_truck)
      @event.add_food_truck(@shack_truck)
    end

    it 'should return a list of all the food truck names' do
      expect(@event.food_truck_names).to eq ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    end
  end



  describe '#food_trucks_that_sell(item)' do
    before :each do
      @event.add_food_truck(@mountain_truck)
      @event.add_food_truck(@nom_truck)
      @event.add_food_truck(@shack_truck)
      
      @mountain_truck.stock(@peach, 35)
      @mountain_truck.stock(@apple, 7)

      @nom_truck.stock(@banana_nice_cream, 50)
      @nom_truck.stock(@peach_nice_cream, 25)

      @shack_truck.stock(@peach, 65)
      @shack_truck.stock(@peach_nice_cream, 10)
    end

    it 'return the trucks that sell the item' do
      expect(@event.food_trucks_that_sell(@peach)).to eq [@mountain_truck, @shack_truck]
    end
  end

 describe '#sorted_item_list' do
  before :each do
    @event.add_food_truck(@mountain_truck)
    @event.add_food_truck(@nom_truck)
    @event.add_food_truck(@shack_truck)
    
    @mountain_truck.stock(@peach, 35)
    @mountain_truck.stock(@apple, 7)

    @nom_truck.stock(@banana_nice_cream, 50)
    @nom_truck.stock(@peach_nice_cream, 25)

    @shack_truck.stock(@peach, 65)
    @shack_truck.stock(@peach_nice_cream, 10)
  end

  it 'sorts items alphabetically' do
    expect(@event.sorted_item_list).to be_a Array
    expect(@event.sorted_item_list.length).to eq 4
  end
 end

  describe '#overstocked_items' do
    before :each do
      @event.add_food_truck(@mountain_truck)
      @event.add_food_truck(@nom_truck)
      @event.add_food_truck(@shack_truck)

      @mountain_truck.stock(@peach, 35)
      @mountain_truck.stock(@apple, 7)

      @nom_truck.stock(@banana_nice_cream, 50)
      @nom_truck.stock(@peach_nice_cream, 25)

      @shack_truck.stock(@peach, 65)
      @shack_truck.stock(@peach_nice_cream, 10)
    end

    it 'returns items that are sold on multiple trucks and quantity over 50' do
      expect(@event.overstocked_items).to eq [@peach]
    end
  end

  describe '#total_inventory' do
    before :each do
      @event.add_food_truck(@mountain_truck)
      @event.add_food_truck(@nom_truck)
      @event.add_food_truck(@shack_truck)

      @mountain_truck.stock(@peach, 35)
      @mountain_truck.stock(@apple, 7)

      @nom_truck.stock(@banana_nice_cream, 50)
      @nom_truck.stock(@peach_nice_cream, 25)

      @shack_truck.stock(@peach, 65)
      @shack_truck.stock(@peach_nice_cream, 10)
    end

    it 'should return a hash of items with the total quantity and what trucks it is on' do
      expect(@event.total_inventory).to be_a Hash
      expect(@event.total_inventory).to have_key @peach
      
      @event.total_inventory.each do |item, info|
        expect(info).to have_key(:food_trucks)
        expect(info[:food_trucks]).to be_a Array
        expect(info).to have_key(:quantity)
      end
    end
  end

  describe '#date' do
    before :each do
      @event.add_food_truck(@mountain_truck)
      @event.add_food_truck(@nom_truck)
      @event.add_food_truck(@shack_truck)

      @mountain_truck.stock(@peach, 35)
      @mountain_truck.stock(@apple, 7)

      @nom_truck.stock(@banana_nice_cream, 50)
      @nom_truck.stock(@peach_nice_cream, 25)

      @shack_truck.stock(@peach, 65)
      @shack_truck.stock(@peach_nice_cream, 10)
    end

    it 'returns the date the event was created on' do
      expect(@event.date).to eq DateTime.now.strftime('%d/%m/%y')
    end
  end

  describe '#sell(item, quantity)' do
    before :each do
      @event.add_food_truck(@mountain_truck)
      @event.add_food_truck(@nom_truck)
      @event.add_food_truck(@shack_truck)

      @mountain_truck.stock(@peach, 35)
      @mountain_truck.stock(@apple, 7)

      @nom_truck.stock(@banana_nice_cream, 50)
      @nom_truck.stock(@peach_nice_cream, 25)

      @shack_truck.stock(@peach, 65)
      @shack_truck.stock(@peach_nice_cream, 10)
    end

    it 'returns false if the event doesnt have enough in stock' do
      expect(@event.sell(@peach, 200)).to eq false
    end

    it 'returns true if the event does have enough in stock' do
      expect(@event.sell(@banana_nice_cream, 5)).to eq true
    end

    it 'if returns true it reducces the stock by the amount' do
      expect(@nom_truck.check_stock(@banana_nice_cream)).to eq 50
      expect(@event.sell(@banana_nice_cream, 5)).to eq true
      expect(@nom_truck.check_stock(@banana_nice_cream)).to eq 45
    end

  end

end
