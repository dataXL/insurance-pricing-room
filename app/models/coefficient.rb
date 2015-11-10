class Coefficient < ActiveRecord::Base
  #serialize :coefficients, HashSerializer
  store_accessor :coefficients, :Intercept

  def self.truncate_me!
    Coefficient.connection.execute("TRUNCATE TABLE coefficients RESTART IDENTITY")
  end
end
