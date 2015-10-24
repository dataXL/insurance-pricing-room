class Risk < ActiveRecord::Base

  def self.truncate_me!
    Risk.connection.execute("TRUNCATE TABLE risks RESTART IDENTITY")
  end
end
