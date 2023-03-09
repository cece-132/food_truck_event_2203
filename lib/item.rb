require 'pry'

class Item
  attr_reader :name, :price
  def initialize(attributes)
    @name = attributes[:name]
    @price = attributes[:price].delete('$').to_i
  end

end
