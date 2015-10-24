class Product < ActiveRecord::Base

  def self.import(file, properties)
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
