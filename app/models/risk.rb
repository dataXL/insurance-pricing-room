class Risk < ActiveRecord::Base
  alias_attribute :tariff, :tariff_id
  belongs_to :tariff

  def self.truncate_me!
    Risk.connection.execute("TRUNCATE TABLE risks RESTART IDENTITY")
  end

  def self.import(file, filters)

    file = File.new("#{Rails.root}/tmp/files/#{file}", "r")

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.sheet(0).row(1)

    (2..spreadsheet.last_row).each do |i|

      row2 = Hash[[header, spreadsheet.row(i)].transpose]
      cost = row2["Custo"].to_f

      row = row2.except!("Custo")
      tariff = Tariff.where(:properties => row.to_json).first.id

      Risk.find(tariff).update_attributes(:cost => cost)

      Competitor.find(tariff).update_attributes({:premium => cost}.reject{|k,v| v.blank?})
      Competitor.find(tariff).update_attributes(:insurer => "My Company")

    end

    pt_id = ProductTemplate.first.id
    ## Add product
    Product.create!(:product_template_id => pt_id, :name => "default", :competitor_id => 1, :properties => {'Price_L':1})

  end

  protected

    def self.friendly
      @friendly ||= columns.map { |column| column.name }
      @friendly.except(["id", "created_at","updated_at"])
    end

    def self.filters
      @filters ||= columns.map { |column| column.name }
      @filters.except(["id", "created_at","updated_at"])
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
