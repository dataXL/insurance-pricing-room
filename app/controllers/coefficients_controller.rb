class CoefficientsController < ApplicationController
  before_action :set_coefficient, only: [:show, :edit, :update, :destroy]

  # GET /coefficients
  # GET /coefficients.json
  def index
    @coefficients = Coefficient.all
  end

  # GET /coefficients/1
  # GET /coefficients/1.json
  def show
  end

  # GET /coefficients/new
  def new
    @coefficient = Coefficient.new
  end

  # GET /coefficients/select
  def select

    ## Save file to tmp/files/
    @name = "#{Time.now.strftime("%Y%m%d%H%M%S")}_#{params[:file].original_filename}"
    directory = "tmp/files"
    path = File.join(directory, @name)
    File.open(path, "wb") { |f| f.write(params[:file].read) }

    file = File.open(path, 'r')

    spreadsheet = Coefficient.open_spreadsheet(file)
    @header = spreadsheet.sheet(0).row(1)
  end

  # GET /coefficients/import
  def import

    file    = params[:file]
    filters = params[:filters]

    Coefficient.import(file, filters)
  end

  def update_async

    @keys = Coefficient.first.coefficients.keys

    @competitors = Competitor.all

    data = []
    @competitors.each do |p|
      temp = Competitor.new(name: p[:name],   premium: p[:premium], tariff_id: p[:tariff_id])
      data << temp
    end

    g = PivotTable::Grid.new do |g|
      g.source_data  = data
      g.column_name  = :name
      g.row_name     = :tariff_id
      g.field_name   = :premium
    end

    @pivot = g.build

    # Handle POST requests
    tariff = params[:tariff]
    @value = params[:value]
    insurer = params[:insurer]

    competitor = Competitor.find_by(name: insurer, tariff_id: tariff)
    competitor.premium = @value
    competitor.save

    respond_to do |format|
      format.js
    end
  end

  # GET /coefficients/1/edit
  def edit
  end

  # POST /coefficients
  # POST /coefficients.json
  def create
    @coefficient = Coefficient.new(coefficient_params)

    respond_to do |format|
      if @coefficient.save
        format.html { redirect_to @coefficient, notice: 'Coefficient was successfully created.' }
        format.json { render :show, status: :created, location: @coefficient }
      else
        format.html { render :new }
        format.json { render json: @coefficient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coefficients/1
  # PATCH/PUT /coefficients/1.json
  def update
    respond_to do |format|
      if @coefficient.update(coefficient_params)
        format.html { redirect_to @coefficient, notice: 'Coefficient was successfully updated.' }
        format.json { render :show, status: :ok, location: @coefficient }
      else
        format.html { render :edit }
        format.json { render json: @coefficient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coefficients/1
  # DELETE /coefficients/1.json
  def destroy
    @coefficient.destroy
    respond_to do |format|
      format.html { redirect_to coefficients_url, notice: 'Coefficient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coefficient
      @coefficient = Coefficient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coefficient_params
      params[:coefficient]
    end

    # Open imported spreadsheet
    def open_spreadsheet(file)
      case File.extname(file.original_filename)
        when ".csv" then Roo::CSV.new(file.path)
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
        else raise "Unknown file type: #{file.original_filename}"
      end
    end
end
