require './lib/item'

RSpec.describe Item do
  before :each do
    @item = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@item).to be_a(Item)
      expect(@item.name).to be_a String
      expect(@item.price).to be_a Integer
    end
  end
end
