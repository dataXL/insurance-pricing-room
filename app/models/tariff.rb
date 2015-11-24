class Tariff < ActiveRecord::Base
  after_initialize :add_field_accessors
  # serialize :properties, HashWithIndifferentAccess
  store_accessor :properties
  attr_accessor :file
  belongs_to :insurer

  def add_store_accessor field_name
      singleton_class.class_eval {store_accessor :properties, field_name}
  end

  def add_field_accessors
    num_fields = properties.try(:keys).try(:count) || 0
    properties.keys.each {|field_name| add_store_accessor field_name} if num_fields > 0
  end

  def self.truncate_me!
    Tariff.connection.execute("TRUNCATE TABLE tariffs RESTART IDENTITY")
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      header = []
      Tariff.column_names.each do |c|
        unless c == "created_at" || c == "updated_at"
          if c == "properties"
            Tariff.first.properties.each do |k,v|
              header << v
            end
          else
            header << c
          end
        end
      end
      csv << header

      row = []
      Tariff.all.tap do |head, *body|
        body.each do |tariff|
          row << tariff.id
          tariff.properties.each do |k,v|
            row << v
          end
          csv << row
        end
      end
    end
  end
end
