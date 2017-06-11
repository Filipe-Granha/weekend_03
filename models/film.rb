# this is one of the class files, where we create the SQL CRUD commands that will connect with the Database in the form of methods


require ('../db/sql_runner')
require_relative ('customer')
require_relative ('ticket')




class Film
 attr_reader :id
 attr_accessor :title, :price, :session


 def initialize (options)
   @id = options['id'].to_i
   @title = options['title']
   @price = options['price'].to_i
   @session = options['session']
 end




 def save() # it's applied in the console file, saving each object directly into the table
   sql = "INSERT INTO films (title, price, session) VALUES ('#{@title}', '#{@price}', '#{@session}') RETURNING id;"
   film = SqlRunner.run(sql).first
   @id = film['id'].to_i
 end




 def update() # working in terminal - console (first step: film1.title="Top Gun"; second step: film1.update)
   sql = "UPDATE films SET (title, price, session) = ('#{@title}', '#{@price}', '#{@session}') WHERE id = #{@id};"
   SqlRunner.run(sql)
 end




 def self.all() # working in terminal - console (eg.: Film.all)
   sql = "SELECT * FROM films;"
   return self.get_many(sql)
 end




 def self.delete_all() # working in terminal - console (eg.: Film.delete_all)
   sql = "DELETE FROM films;"
   SqlRunner.run(sql)
 end




 def delete() # working in terminal - console (eg.: film1.delete)
   sql = "DELETE FROM films WHERE id = #{@id};"
   SqlRunner.run(sql)
 end




 def customers() # working in terminal - console (eg.: film1.customers)
   sql = "SELECT customers.* FROM customers 
   INNER JOIN tickets ON tickets.customer_id = customers.id 
   WHERE film_id = #{@id};"
   return Customer.get_many(sql)
 end




 # (Checks how many tickets were bought by a customer)
 def number_of_customers_watching() # working in terminal - console (eg.: .number_of_customers_watching)
   return customers.count
 end




 def self.get_many(sql) # to be used inside other methods that return to us a collection of data we're looking for
   films = SqlRunner.run(sql)
   result = films.map { |film| Film.new(film) }
   return result
 end




# two failed attempts at creating table with title and screening sessions

 # def self.screening_sessions
 #  sql = "SELECT title, session FROM films;"
 #  result = SqlRunner.run(sql)
 #  return result
 # end

# def self.screenings() 
#   sql = "SELECT title, session INTO screenings
#   FROM films;"
#   return self.get_many(sql)
# end




end