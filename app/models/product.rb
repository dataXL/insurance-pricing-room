class Product < ActiveRecord::Base
  serialize :properties, HashSerializer
  store_accessor :properties, :vehicles_category

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      product.properties = row.to_hash.slice(*accessible_attributes)
      product.save!
    end
  end
end
