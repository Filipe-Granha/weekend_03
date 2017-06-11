require('pry-byebug')
require_relative('../models/film')
require_relative('../models/customer')
require_relative('../models/ticket')




Ticket.delete_all()
Customer.delete_all()
Film.delete_all()




customer1 = Customer.new ({
  'name' => 'Tony',
  'funds' => '20'
  })
customer1.save() # saves objects to the table
customer2 = Customer.new ({
  'name' => 'Zsolt',
  'funds' => '20'
  })
customer2.save()
customer3 = Customer.new ({
  'name' => 'Sandy',
  'funds' => '20'
  })
customer3.save()
customer4 = Customer.new ({
  'name' => 'Jarrod',
  'funds' => '20'
  })
customer4.save()




film1 = Film.new ({
  'title' => 'Matrix',
  'price' => '10',
  'session' => '8:00'
  })
film1.save()
film2 = Film.new ({
  'title' => 'Commando',
  'price' => '10',
  'session' => '8:00'
  })
film2.save()
film3 = Film.new ({
  'title' => 'American Beauty',
  'price' => '10',
  'session' => '8:00'
  })
film3.save()
film4 = Film.new ({
  'title' => 'Interstellar',
  'price' => '10',
  'session' => '9:00'
  })
film4.save()




ticket1 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })
ticket1.save()
ticket2 = Ticket.new ({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  })
ticket2.save()
ticket3 = Ticket.new ({
  'customer_id' => customer3.id,
  'film_id' => film1.id
  })
ticket3.save()
ticket4 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })
ticket4.save()
ticket5 = Ticket.new ({
  'customer_id' => customer4.id,
  'film_id' => film2.id
  })
ticket5.save()
ticket6 = Ticket.new ({
  'customer_id' => customer2.id,
  'film_id' => film3.id
  })
ticket6.save()





binding.pry
nil