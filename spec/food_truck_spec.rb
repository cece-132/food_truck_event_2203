require './lib/item'
require './lib/food_truck'

RSpec.describe FoodTruck do
  before :each do
    @peach = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @apple = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @mountain_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@mountain_truck).to be_a(FoodTruck)
      expect(@mountain_truck.name).to be_a String
      expect(@mountain_truck.inventory).to be_a Hash
      expect(@mountain_truck.inventory).to be_empty
    end
  end

  describe '#check_stock(item)' do
    it 'can view how many of an item is in inventory' do
      expect(@mountain_truck.check_stock(@peach)).to eq 0
    end
  end

  before :each do
    @mountain_truck.stock(@peach, 35)
    @mountain_truck.stock(@apple, 7) 
  end


  describe '#stock_item(item, amount)' do
    it 'adds an item to inventory' do
      expect(@mountain_truck.inventory).to have_key(@peach)
    end

    it 'adds to item quantity if item exists in inventory' do
      @mountain_truck.stock(@peach, 30)
      expect(@mountain_truck.check_stock(@peach)).to eq 60
    end
  end

  describe '#potential_revenue' do
    it 'can calculate the revenue of a food truck' do
      expect(@mountain_truck.potential_revenue).to eq 148.75
    end
  end

end
