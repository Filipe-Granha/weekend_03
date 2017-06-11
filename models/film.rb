# this is one of the class files, where we create the SQL CRUD commands that will connect with the Database in the form of methods


require ('../db/sql_runner')
require_relative ('customer')
require_relative ('ticket')



class Film
 attr_reader :id
 attr_accessor :title, :price


 def initialize (options)
   @id = options['id'].to_i
   @title = options['name']
   @price = options['price'].to_i
 end




 def save() # it's applied in the console file, saving each object directly into the table
   sql = "INSERT INTO films (title, price) VALUES ('#{@title}', '#{@price}') RETURNING id;"
   film = SqlRunner.run(sql).first
   @id = film['id'].to_i
 end




 def update() # working in terminal - console
   sql = "UPDATE films SET (title, price) = ('#{@title}', '#{@price}') WHERE id = #{@id};"
   SqlRunner.run(sql)
 end




 def self.all() # working in terminal - console
   sql = "SELECT * FROM films;"
   return self.get_many(sql)
 end




 def self.delete_all()
   sql = "DELETE FROM films;"
   SqlRunner.run(sql)
 end




 def delete()
   sql = "DELETE FROM films WHERE id = #{@id};"
   SqlRunner.run(sql)
 end




 def customers() # working in terminal - console (eg.: film1.customers)
   sql = "SELECT customers.* FROM customers 
         INNER JOIN tickets ON tickets.customer_id = customers.id 
         WHERE film_id = #{@id};"
   return Customer.get_many(sql)
 end




 def self.get_many(sql)
   films = SqlRunner.run(sql)
   result = films.map { |film| Film.new(film) }
   return result
 end


end