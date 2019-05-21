require('pry')
require_relative('models/house.rb')

House.delete_all()

house1 = House.new(
  {
    'address' => '5 main street',
    'value' => 100000,
    'bedroom_num' => 3,
    'buy_let' => 'buy'
  }
)


house2 = House.new(
  {
    'address' => '7 back street',
    'value' => 150000,
    'bedroom_num' => 4,
    'buy_let' => 'buy'
  }
)

house1.save()
house2.save()

house1.value = 110000

house1.update()

# house2.delete()

found_house = House.find_by_id(21)

found_house2 = House.find_by_address('7 back street')

houses = House.all()
binding.pry
nil
