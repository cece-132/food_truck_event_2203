require './lib/item'
require './lib/food_truck'

RSpec.describe FoodTruck do
  before :each do
    @peach = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @apple = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@food_truck).to be_a(FoodTruck)
      expect(@food_truck.name).to be_a String
      expect(@food_truck.inventory).to be_a Hash
      expect(@food_truck.inventory).to be_empty
    end
  end

  describe '#check_stock(item)' do
    it 'can view how many of an item is in inventory' do
      expect(@food_truck.check_stock(@peach)).to eq 0
    end
  end

  describe '#stock_item(item, amount)' do
    before :each do
      @food_truck.stock(@peach, 30)      
    end

    it 'adds an item to inventory' do
      expect(@food_truck.inventory).to have_key(@peach)
    end

    it 'adds to item quantity if item exists in inventory' do
      @food_truck.stock(@peach, 30)
      expect(@food_truck.check_stock(@peach)).to eq 60
    end
  end
  
end
