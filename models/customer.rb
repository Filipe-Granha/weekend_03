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




  def self.delete_all() # working in terminal - console (eg.: Customer.delete_all)
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end




  def delete() # working in terminal - console (eg.: customer1.delete)
    sql = "DELETE FROM customers WHERE id = #{@id};"
    SqlRunner.run(sql)
  end




  def films() # working in terminal - console (eg.: customer1.films)
    sql = "SELECT films.* FROM films 
    INNER JOIN tickets ON tickets.film_id = films.id 
    WHERE customer_id = #{@id};"
    return Film.get_many(sql)
  end




  # (Checks how many tickets were bought by a customer)
  def number_of_tickets_bought() # working in terminal - console (eg.: customer1.number_of_tickets_bought)
    return films.count
  end




  # def update_funds
  #     sql = "SELECT films.price, customers.funds FROM films
  #       INNER JOIN tickets
  #       ON tickets.film_id = films.id
  #       INNER JOIN customers
  #       ON customers.id = tickets.customer_id
  #       WHERE tickets.customer_id = #{@id};"
  #     result_hash = SqlRunner.run(sql)[0]
  #     result = result_hash["funds"].to_i - result_hash["price"].to_i
  #     return result
  #   end

  # based on the above answer shown on Slack
    def update_funds
        sql = "SELECT customers.funds, films.price
          FROM customers
          INNER JOIN tickets
          ON customers.id = tickets.customer_id
          INNER JOIN films
          ON films.id = tickets.film_id
          WHERE tickets.film_id = #{@id};"
        result = SqlRunner.run(sql)[0]
        funds = result["funds"].to_i - result["price"].to_i
        return funds
      end




  def self.get_many(sql) # to be used inside other methods that return to us a collection of data we're looking for
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end




  # FIND METHOD ---> not sure how to use it
    # def find()
    #   sql = "SELECT * FROM customers WHERE id = #{id}"
    #   SqlRunner.run(sql)
    # end




end