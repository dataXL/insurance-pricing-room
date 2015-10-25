class Competitor < ActiveRecord::Base

  def self.truncate_me!
    Competitor.connection.execute("TRUNCATE TABLE competitors RESTART IDENTITY")
  end
end
