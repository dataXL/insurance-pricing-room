class RisksController < ApplicationController
  before_action :set_risk, only: [:show, :edit, :update, :destroy]
  respond_to :json

  # GET /risks
  # GET /risks.json
  def index
    @risks = Risk.all
  end

  # GET /risks/1
  # GET /risks/1.json
  def show
  end

  # GET /risks/new
  def new
    @risk = Risk.new
  end

  # GET /risks/select
  def select

    ## Save file to tmp/files/
    @name = "#{Time.now.strftime("%Y%m%d%H%M%S")}_#{params[:file].original_filename}"

    directory = "#{Rails.root}/tmp/files"

    Dir.mkdir(directory) unless File.exists?(directory)

    path = File.join(directory, @name)
    File.open(path, "wb") { |f| f.write(params[:file].read) }

    file = File.open(path, 'r')

    spreadsheet = Risk.open_spreadsheet(file)
    @header = spreadsheet.sheet(0).row(1)
  end

  # GET /risks/import
  def import

    file    = params[:file]
    filters = params[:filters]

    Risk.import(file, filters)
  end

  # GET /risks/1/edit
  def edit
  end

  # POST /risks
  # POST /risks.json
  def create
    @risk = Risk.new(risk_params)

    respond_to do |format|
      if @risk.save
        format.html { redirect_to @risk, notice: 'Risk was successfully created.' }
        format.json { render :show, status: :created, location: @risk }
      else
        format.html { render :new }
        format.json { render json: @risk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /risks/1
  # PATCH/PUT /risks/1.json
  def update
    respond_to do |format|
      if @risk.update(risk_params)
        format.html { redirect_to @risk, notice: 'Risk was successfully updated.' }
        format.json { render :show, status: :ok, location: @risk }
      else
        format.html { render :edit }
        format.json { render json: @risk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /risks/1
  # DELETE /risks/1.json
  def destroy
    @risk.destroy
    respond_to do |format|
      format.html { redirect_to risks_url, notice: 'Risk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_risk
      @risk = Risk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def risk_params
      params[:risk]
    end

    def open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
