class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.all

    bars = []
    products = []
    results = Survey.select(:product_name, "SUM(answer)").group(:product_name).order(:product_name)
    results.each_with_index do |r, index|
      bars << [r.product_name, r.sum]
      products <<  [index, r.product_name]
    end
    gon.bars = bars
    gon.products = products
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /tariffs/select
  def select
    spreadsheet = open_spreadsheet(params[:file])
    @header = spreadsheet.sheet(0).row(1)

    Survey.truncate_me!

    for i in 1..@header.length
      temp = spreadsheet.sheet(0).column(i)
      temp.tap do |head, *body|
        body.each do |b|
          Survey.create!(:product_name => head, :answer => b.to_i)
        end
      end
    end
  end

  # GET /tariffs/import
  def import
    @filters = params[:properties]
    unless @filters.nil?
      @filters.each do |filter|

        @results = Tariff.where('properties ?| array[:keys]', keys: [filter])
        @results.each do |result|
          result.update_attribute :properties, result[:properties].except(filter)
        end
      end
    end
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params[:survey]
    end

    # Open imported spreadsheet
    def open_spreadsheet(file)
      case File.extname(file.original_filename)
        when ".csv" then Roo::CSV.new(file.path, csv_options: {col_sep: ";"})
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
        else raise "Unknown file type: #{file.original_filename}"
      end
    end
end
