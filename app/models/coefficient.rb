class Coefficient < ActiveRecord::Base
  store_accessor :intercept
  after_initialize :add_field_accessors
  #serialize :coefficients, HashSerializer
  store_accessor :coefficients

  def self.truncate_me!
    Coefficient.connection.execute("TRUNCATE TABLE coefficients RESTART IDENTITY")
  end

  def add_store_accessor field_name
      singleton_class.class_eval {store_accessor :coefficients, field_name}
  end

  def add_field_accessors
    num_fields = coefficients.try(:keys).try(:count) || 0
    coefficients.keys.each {|field_name| add_store_accessor field_name} if num_fields > 0
  end

  def self.import(file, filters)

    file = File.new("#{Rails.root}/tmp/files/#{file}", "r")

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.sheet(0).row(1)

    Coefficient.truncate_me!

    (2..spreadsheet.last_row).each do |i|

      row2 = Hash[[header, spreadsheet.row(i)].transpose]
      intercept = row2["CONSTANT"].to_f

      row = row2.except!("CONSTANT")
      row.update(row){ |k,v| v.to_f }

      Coefficient.create!(:intercept => intercept, :coefficients => row, :product_template_id => 1)
    end
  end

  protected

    def self.friendly
      @friendly ||= columns.map { |column| column.name }
      @friendly.except(["id", "created_at","updated_at","product_template_id"])
    end

    def self.open_spreadsheet(file)
      case File.extname(file.path)
        when ".csv" then Roo::CSV.new(file.path)
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
        else raise "Unknown file type: #{file.path}"
      end
    end

  private
end
