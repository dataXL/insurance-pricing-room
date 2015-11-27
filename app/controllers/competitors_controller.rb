class CompetitorsController < ApplicationController
  before_action :all_competitors, only: :index
  before_action :set_competitors, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  require 'roo'

  # GET /competitors
  # GET /competitors.json
  def index
    @competitors = Competitor.all

    bars = []
    insurers = []

    @competitors.each_with_index do |k, index|
      bars << [k, k.premium]
      insurers <<  [index, k.name]
    end

    gon.bars = bars
    gon.insurers = insurers

    respond_to do |format|
      format.html
      format.js
    end
  end


  def grid
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

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /competitors/1
  # GET /competitors/1.json
  def show
    product = Competitor.find_by_id(params[:id])
  end

  # GET /competitors/1/edit
  def edit
  end

  # POST /competitors
  # POST /competitors.json
  def create
    @product = Competitor.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Competitor was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /competitors/new
  def new
    @product = Competitor.new
  end

  # GET /competitors/select
  def select

    ## Save file to tmp/files/
    @name = "#{Time.now.strftime("%Y%m%d%H%M%S")}_#{params[:file].original_filename}"
    directory = "tmp/files"
    path = File.join(directory, @name)
    File.open(path, "wb") { |f| f.write(params[:file].read) }

    file = File.open(path, 'r')

    spreadsheet = Risk.open_spreadsheet(file)
    @header = spreadsheet.sheet(0).row(1)
  end

  # GET /tariffs/import
  def import

    file    = params[:file]
    filters = params[:filters]

    Competitor.import(file, filters)
  end

  # PATCH/PUT /competitors/1
  # PATCH/PUT /competitors/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competitors/1
  # DELETE /competitors/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to competitors_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def all_competitors
      @competitors = Product.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:product, :file)
    end

end
