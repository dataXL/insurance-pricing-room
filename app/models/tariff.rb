class Tariff < ActiveRecord::Base
  after_initialize :add_field_accessors
  #after_save :fetch_cost
  #after_save :fect_price
  # serialize :properties, HashWithIndifferentAccess
  store_accessor :properties
  attr_accessor :file
  belongs_to :insurer
  has_one :risk, dependent: :destroy
  has_many :competitors, dependent: :destroy

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
      Tariff.friendly.each do |c|
        if c == "properties"
          Tariff.first.properties.each do |k,v|
            header << v
          end
        else
          header << c
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

  def self.import(file, filters)

    file = File.new("#{Rails.root}/tmp/files/#{file}", "r")

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.sheet(0).row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      filtered = {}
      filters.each { |f| filtered[f] = row[f] }

      tariff = Tariff.create!(:properties => filtered)

      tariff.build_risk.save
      tariff.competitors.build(:insurer => "My Company").save
    end

    ## Add product template
    ProductTemplate.create!(:name => "default", :tag => "insurance", :properties => {'Price':1,'Brand':1})
  end

  protected

    def self.friendly
      @friendly ||= columns.map { |column| column.name }
      @friendly.except(["created_at","updated_at"])
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
        else
          raise "Unknown file type: #{file.path}"
      end
    end
end
