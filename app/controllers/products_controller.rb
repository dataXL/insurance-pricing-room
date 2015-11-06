class ProductsController < ApplicationController
	before_action :all_products, only: :index
	before_action :set_product, only: [:show, :edit, :update, :destroy]
	respond_to :html, :js

	require 'roo'

	# GET /products
	# GET /products.json
	def index
		Product.truncate_me!

		# Companhias: Mapfre, Generali, Zurich
		# Preço: Baixo, Medio, Alto
		# Cobertiras: RC, RC+AV, DP

		insurers = ["Mapfre", "Generali", "Zurich"]
		prices = ["Baixo", "Medio", "Alto"]
		coverages = ["RC","RC+AV","DP"]

		# Generate all possible permutations
		permutations = (array_permutations [insurers, prices, coverages]).map {|x| x.split(";")}

		(0...permutations.length).each do |i|

			hash = {}
			permutations[i].each do |s|
				if insurers.include? (s)
					hash["insurer"] = s
				elsif prices.include? (s)
					hash["price"] = s
				else coverages.include? (s)
					hash["coverage"] = s
				end
			end
			Product.create!(:name => "Product #{i+1}", :properties => hash)
		end

		@products = Product.all
	end

	def grid
		@products = Product.all

		data = []
		#@products.each do |p|
			#@test = Competitor.new(name: "p[:name]",   premium: "p[:premium]", tariff_id: "p[:tariff_id]")
			@test = ProductsController::Pivot.new
			#data << temp
		#end
	end

	class Pivot

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

	# GET /products/new
	def new
		@product = Product.new
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

		def array_permutations array
			return array[0] if array.size == 1
			first = array.shift
			return first.product( array_permutations(array) ).map {|x| x.flatten.join(";")}
		end
end
