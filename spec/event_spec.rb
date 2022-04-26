require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do 262.5
  before :each do
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  it "exists" do
    expect(@event).to be_a(Event)
  end

  it "has attributes" do
    expect(@event.name).to eq("South Pearl Street Farmers Market")
    expect(@event.food_trucks).to eq([])
  end

  it "can add food trucks to an event" do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
  end

  it "can recall the truck names" do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it "can place items in trucks" do
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)

    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)

    @food_truck3.stock(@item1, 65)

    expect(@food_truck1.inventory).to eq({@item1 => 35, @item2 => 7})
    expect(@food_truck2.inventory).to eq({@item4 => 50, @item3 => 25})
    expect(@food_truck3.inventory).to eq({@item1 => 65})
  end

  it "can identify what items each truck sells" do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)

    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)

    @food_truck3.stock(@item1, 65)

    expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1,@food_truck3])
    expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
    # got stuck here The code almost worked except I couldn't figure how to get
    # my array to reset every time it went through. but it also seemed like I
    # couldn't figure out what the error was. because the "got-statement" and
    # expected statement seemed the same to me.
  end

end
