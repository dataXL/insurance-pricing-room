class Coefficient < ActiveRecord::Base

  def self.truncate_me!
    Coefficient.connection.execute("TRUNCATE TABLE coefficients RESTART IDENTITY")
  end
end
