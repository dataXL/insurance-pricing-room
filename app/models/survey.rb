class Survey < ActiveRecord::Base

  def self.truncate_me!
    Survey.connection.execute("TRUNCATE TABLE surveys RESTART IDENTITY")
  end
end
