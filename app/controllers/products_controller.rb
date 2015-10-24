class ProductsController < ApplicationController
  before_action :all_products, only: :index
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  require 'roo'

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end


  def grid
    @products = Product.all

    data = []
    @products.each do |p|
      temp = Product.new(insurer: p[:insurer],   premium: p[:premium], tariff_id: p[:tariff_id])
      data << temp
    end

    g = PivotTable::Grid.new do |g|
      g.source_data  = data
      g.column_name  = :insurer
      g.row_name     = :tariff_id
      g.field_name   = :premium
    end

    @pivot = g.build
  end

  # GET /products/1
  # GET /products/1.json
  def show
    product = Product.find_by_id(params[:id])
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
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

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/select
  def select
    spreadsheet = open_spreadsheet(params[:file])
    @header = spreadsheet.sheet(0).row(1)
    puts @header.inspect

    @options = Hash.new
    #@test = transliterate('JÃ¼rgen')

    #Product.import(params[:file])
  end

  # GET /products/filter
  def filter
    unless @header.blank?
      #for i in 0..(@header.size - 1)
        @test = { params[:option0] => "test" }
        puts @test.inspect
      #end
    end

    #if params[:option0].first == "true"
      #@test = "Yes!"
      #@test2 = params[:radio0]
    #elsif params[:option0].first == "false"
      #@test = "No!"
    #else
      #@test = params[:option0]
    #end
  end

  # GET /products/import
  def import

  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
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

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def all_products
      @products = Product.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params[:product]
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
