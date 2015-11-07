class ProductTemplatesController < ApplicationController
  before_action :set_product_template, only: [:show, :edit, :update, :destroy]

  # GET /product_templates
  # GET /product_templates.json
  def index
    @product_templates = ProductTemplate.all
  end

  # GET /product_templates/1
  # GET /product_templates/1.json
  def show
    @product_template = ProductTemplate.find(params[:id])
    @keys = @product_template.properties.keys
    @values = @product_template.properties.values
  end

  # GET /product_templates/new
  def new
    @product_template = ProductTemplate.new
  end

  def build
    @template = params[:template]
  end

  def save

    properties = Hash.new
    params[:properties].each do |p|
      properties.merge!(Hash[p[1][:name],Hash["type", p[1][:type], "values", (p[1][:values]).split(",")]])
    end
    ProductTemplate.create!(:name => params[:template], :properties => properties)
  end

  # GET /product_templates/1/edit
  def edit
  end

  # POST /product_templates
  # POST /product_templates.json
  def create
    @product_template = ProductTemplate.new(product_template_params)

    respond_to do |format|
      if @product_template.save
        format.html { redirect_to @product_template, notice: 'Product template was successfully created.' }
        format.json { render :show, status: :created, location: @product_template }
      else
        format.html { render :new }
        format.json { render json: @product_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_templates/1
  # PATCH/PUT /product_templates/1.json
  def update
    respond_to do |format|
      if @product_template.update(product_template_params)
        format.html { redirect_to @product_template, notice: 'Product template was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_template }
      else
        format.html { render :edit }
        format.json { render json: @product_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_templates/1
  # DELETE /product_templates/1.json
  def destroy
    @product_template.destroy
    respond_to do |format|
      format.html { redirect_to product_templates_url, notice: 'Product template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_template
      @product_template = ProductTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_template_params
      params[:product_template]
    end
end
