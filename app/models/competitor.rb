class Competitor < ActiveRecord::Base
  belongs_to :tariff

  def self.truncate_me!
    Competitor.connection.execute("TRUNCATE TABLE competitors RESTART IDENTITY")
  end

  def self.import(file, filters)

    file = File.new("#{Rails.root}/tmp/files/#{file}", "r")

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.sheet(0).row(1)

    (2..spreadsheet.last_row).each do |i|
      spreadsheet.row(i)
      row2 = Hash[[header, spreadsheet.row(i)].transpose]
      premium = row2["Premio comercial"].to_f
      name = row2["Companhia"].to_s

      row = row2.except!("Premio comercial","Companhia")
      tariff = Tariff.where(:properties => row.to_json).first.id

      p = Competitor.create!(:premium => premium, :tariff_id => tariff, :name => name)
    end
  end

  protected

    def self.open_spreadsheet(file)
      case File.extname(file.path)
        when ".csv" then Roo::CSV.new(file.path)
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
        else raise "Unknown file type: #{file.path}"
      end
    end
end
