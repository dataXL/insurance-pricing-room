class Survey < ActiveRecord::Base

  def self.truncate_me!
    Survey.connection.execute("TRUNCATE TABLE surveys RESTART IDENTITY")
  end

  def self.import(file, filters)

    file = File.new("#{Rails.root}/tmp/files/#{file}", "r")

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.sheet(0).row(1)

    Survey.truncate_me!

    for i in 1..header.length
      temp = spreadsheet.sheet(0).column(i)
      temp.tap do |head, *body|
        body.each do |b|
          Survey.create!(:product => head, :answer => b.to_i)
        end
      end
    end
  end

  protected

    def self.friendly
      @friendly ||= columns.map { |column| column.name }
      @friendly.except(["created_at","updated_at","product_id"])
    end

    def self.open_spreadsheet(file)
      case File.extname(file.path)
        when ".csv" then Roo::CSV.new(file.path, csv_options: {col_sep: ";"})
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
        else raise "Unknown file type: #{file.path}"
      end
    end
end
