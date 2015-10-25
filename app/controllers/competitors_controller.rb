class CompetitorsController < ApplicationController
  before_action :all_competitors, only: :index
  before_action :set_competitors, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  require 'roo'

  # GET /competitors
  # GET /competitors.json
  def index
    @competitors = Competitor.all
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

  def complete
    @test = params[:task_ids]
    puts @test.inspect
    render :new
  end

  # GET /competitors/new
  def new
    @product = Competitor.new
  end

  # GET /competitors/select
  def select
    spreadsheet = open_spreadsheet(params[:file])
    @header = spreadsheet.sheet(0).row(1)

    Competitor.truncate_me!

    #spreadsheet.last_row
    (2..2).each do |i|
      spreadsheet.row(i)
      row2 = Hash[[@header, spreadsheet.row(i)].transpose]
      premium = row2["Premio comercial"].to_f
      name = row2["Companhia"].to_s

      row = row2.except!("Premio comercial","Companhia")
      tariff = Tariff.where(:properties => row.to_json).first.id

      p = Competitor.create!(:premium => premium, :tariff_id => tariff, :name => name)
    end
  end

  # GET /tariffs/import
  def import

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

    def open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
