class TariffsController < ApplicationController
  before_action :set_tariff, only: [:show, :edit, :update, :destroy]

  # GET /tariffs
  # GET /tariffs.json
  def index
    @tariffs = Tariff.all

    respond_to do |format|
      format.html
      format.csv { send_data @tariffs.to_csv(:col_sep => ";") }
    end
  end

  # GET /tariffs/1
  # GET /tariffs/1.json
  def show
    @header = Tariff.column_names
    @tariff = Tariff.find(params[:id])
  end

  # GET /tariffs/new
  def new
    @tariff = Tariff.new
  end

  # GET /tariffs/select
  def select
    # Save file to tmp/tariffs/
    @name = "#{DateTime.now.to_i}_#{params[:file].original_filename}"
    directory = "tmp/tariffs"
    path = File.join(directory, @name)
    File.open(path, "wb") { |f| f.write(params[:file].read) }

    file = File.open(path, 'r')

    spreadsheet = open_spreadsheet(file)
    @header = spreadsheet.sheet(0).row(1)


    # Tariff.truncate_me!
    # Risk.truncate_me!

    #@headerhash = {}
    #@header.each do |value|
    #  key = I18n.transliterate(value).gsub(/\s/, '_').gsub(/[^0-9A-Za-z](_)/, '').downcase
    #  @headerhash[key] = value
    #end

    #row.except!("Premio comercial".to_sym).each_key { |x|
    #    row[x] = row[x].to_s.strip if row[x]
    #    @test << row[x]
    #  }

    #Tariff.create!(:properties => @headerhash)



    # @test = []
    # (2..spreadsheet.last_row).each do |i|
    #   spreadsheet.row(i)
    #   row = Hash[[@header, spreadsheet.row(i)].transpose].except!("Premio comercial")
    #   premium = row["Premio comercial"].to_f
    #   t = Tariff.create!(:properties => row, :premium => premium, :insurer_id => 1)

    #   Risk.find_or_create_by(tariff_id: t.id)
    #   Product.find_or_create_by(tariff_id: t.id, premium: premium, :insurer => t.insurer.name)
    # end
  end

  # GET /tariffs/import
  def import
    @filters = params[:properties]
    @name = params[:file]

    directory = "tmp/tariffs"
    path = File.join(directory, @name)

    file = File.new(path, "r")

    spreadsheet = open_spreadsheet(file)
    @header = spreadsheet.sheet(0).row(1)



    (2..spreadsheet.last_row).each do |i|      
      row = Hash[[@header, spreadsheet.row(i)].transpose].except!("Premio comercial")
      premium = row["Premio comercial"].to_f

      hash = {}
      @filters.each { |f| hash[f] = row[f] }

      tariff = Tariff.create!(:properties => hash, :premium => premium, :insurer_id => 1)

      Risk.find_or_create_by(tariff_id: tariff.id)
      Product.find_or_create_by(tariff_id: tariff.id, premium: premium, :insurer => tariff.insurer.name)
    end
  end

  # Set properties and levels
  def custom

  end

  # GET /tariffs/1/edit
  def edit
  end

  # POST /tariffs
  # POST /tariffs.json
  def create
    @tariff = Tariff.new(tariff_params)

    respond_to do |format|
      if @tariff.save
        format.html { redirect_to @tariff, notice: 'Tariff was successfully created.' }
        format.json { render :show, status: :created, location: @tariff }
      else
        format.html { render :new }
        format.json { render json: @tariff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tariffs/1
  # PATCH/PUT /tariffs/1.json
  def update
    respond_to do |format|
      if @tariff.update(tariff_params)
        format.html { redirect_to @tariff, notice: 'Tariff was successfully updated.' }
        format.json { render :show, status: :ok, location: @tariff }
      else
        format.html { render :edit }
        format.json { render json: @tariff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tariffs/1
  # DELETE /tariffs/1.json
  def destroy
    @tariff.destroy
    respond_to do |format|
      format.html { redirect_to tariffs_url, notice: 'Tariff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tariff
      @tariff = Tariff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tariff_params
      params.require(:tariff).permit(:tariff, :properties)
    end

    # Open imported spreadsheet
    def open_spreadsheet(file)
      case File.extname(file.path)
        when ".csv" then Roo::Csv.new(file.path)
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
        else raise "Unknown file type: #{file.original_filename}"
      end
    end

    # Test if string is number
    def is_number? string
      true if Float(string) rescue false
    end
end
