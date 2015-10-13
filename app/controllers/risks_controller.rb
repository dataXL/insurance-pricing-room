class RisksController < ApplicationController
  before_action :set_risk, only: [:show, :edit, :update, :destroy]
  respond_to :json

  # GET /risks
  # GET /risks.json
  def index
    @header = Risk.column_names
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
    spreadsheet = open_spreadsheet(params[:file])
    @header = spreadsheet.sheet(0).row(1)
    puts @header.inspect

    @options = Hash.new
    #@test = transliterate('JÃ¼rgen')

    #Product.import(params[:file])
  end

  # GET /risks/filter
  def filter
    unless @header.blank?
      #for i in 0..(@header.size - 1)
        @test = { params[:option0] => "test" }
        puts @test.inspect
      #end
    end
  end

  # GET /risks/import
  def import

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
      when ".csv" then Roo::Csv.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
