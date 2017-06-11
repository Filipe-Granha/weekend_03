# this is one of the class files, where we create the SQL CRUD commands that will connect with the Database in the form of methods


require ('../db/sql_runner')
require_relative ('customer')
require_relative ('film')



class Ticket
 attr_reader :id
 attr_accessor :customer_id, :film_id


 def initialize (options)
   @id = options['id'].to_i
   @customer_id = options['customer_id'].to_i
   @film_id = options['film_id'].to_i
 end




 def save() # it's applied in the console file, saving each object directly into the table
   sql = "INSERT INTO tickets (customer_id, film_id) VALUES ('#{@customer_id}', '#{@film_id}') RETURNING id;"
   ticket = SqlRunner.run(sql).first
   @id = ticket['id'].to_i
 end



# UPDATE METHOD --> wouldn't make sense using it, since we can't change the foreign keys from the customer_id and film_id
 # def update()
 #   sql = "UPDATE tickets SET (customer_id, film_id) = ('#{@customer_id}', '#{@film_id}') WHERE id = #{@id};"
 #   SqlRunner.run(sql)
 # end





 def self.all() # working in terminal - console (eg.: Ticket.all)
   sql = "SELECT * FROM tickets;"
   return self.get_many(sql)
 end




 def self.delete_all() # working in terminal - console (eg.: Ticket.delete_all)
   sql = "DELETE FROM tickets;"
   SqlRunner.run(sql)
 end




 def delete() # working in terminal - console (eg.: ticket1.delete)
   sql = "DELETE FROM tickets WHERE id = #{@id};"
   SqlRunner.run(sql)
 end




 def film() # working in terminal - console (eg.: ticket1.film)
   sql = "SELECT * FROM films WHERE id = #{@film_id}"
   film = SqlRunner.run(sql).first
   return Film.new(film)
 end  




 def customer() # working in terminal - console (eg.: ticket1.customer)
   sql = "SELECT * FROM customers WHERE id = #{@customer_id}"
   customer = SqlRunner.run(sql).first
   return Customer.new(customer)
 end  




 def self.get_many(sql) # to be used inside other methods that return to us a collection of data we're looking for
   tickets = SqlRunner.run(sql)
   result = tickets.map { |ticket| Ticket.new(ticket) }
   return result
 end


end