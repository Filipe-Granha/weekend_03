# this is one of the class files, where we create the SQL CRUD commands that will connect with the Database in the form of methods


require ('../db/sql_runner')
require_relative ('film')
require_relative ('ticket')



class Customer
  attr_reader :id #never apply attr_acessor to :id
  attr_accessor :name, :funds


  def initialize (options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end




  def save() # it's applied in the console file, saving each object directly into the table
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', '#{@funds}') RETURNING id;"
    customer = SqlRunner.run(sql).first
    @id = customer['id'].to_i
  end




  def update() # working in terminal - console (first step: customer1.name="Filipe"; second step: customer1.update)
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', '#{@funds}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end




  def self.all() # working in terminal - console (eg.: Customer.all)
    sql = "SELECT * FROM customers;"
    return self.get_many(sql)
  end




  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end




  def delete()
    sql = "DELETE FROM customers WHERE id = #{@id};"
    SqlRunner.run(sql)
  end




  def films() # working in terminal - console (eg.: customer1.films)
    sql = "SELECT films.* FROM films 
          INNER JOIN tickets ON tickets.film_id = films.id 
          WHERE customer_id = #{@id};"
    return Film.get_many(sql)
  end




  def self.find()
    sql = "SELECT * FROM customers WHERE id = #{id}"
    SqlRunner.run(sql)
  end







  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end




end