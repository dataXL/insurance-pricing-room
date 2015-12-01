class Product < ActiveRecord::Base
  attr_accessor :premium

  def self.truncate_me!
    Product.connection.execute("TRUNCATE TABLE products RESTART IDENTITY")
  end

  def logit_p
    self.logit_e / Product.sum("logit_e")
  end

  def mine
  end

  def utility(premium)
  end
end
