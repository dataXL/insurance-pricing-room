class Crawler < ActiveRecord::Base
  after_initialize :add_field_accessors

  def add_store_accessor field_name
      singleton_class.class_eval {store_accessor :fields, field_name}
  end

  def add_field_accessors
    num_fields = fields.try(:keys).try(:count) || 0
    fields.keys.each {|field_name| add_store_accessor field_name} if num_fields > 0
  end
end
