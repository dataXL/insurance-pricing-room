class HomeController < ApplicationController
  # before_action :authenticate_user!, only: [:dashboard]

	def index
    render layout: "empty"
	end

  def dashboard
    @ctariff = Tariff.first.id

    @mycompany = Competitor.find_by(:tariff_id => @ctariff, :insurer => "My Company")
    #@product = Product.find_by(:brand => "My Company")

    xs, ys = [1.2,4.5], [5.6,8.7]

    linear_model = SimpleLinearRegression.new(xs, ys)
    puts "Model generated with"
    puts "Slope: #{linear_model.slope}"
    puts "Y-Intercept: #{linear_model.y_intercept}"
    puts "\n"
    puts "Estimated Linear Model:"
    puts "Y = #{linear_model.y_intercept} + (#{linear_model.slope} * X)"
  end

  def grid
    @ctariff = Tariff.first.id
    @competitors = Competitor.all
    @products = Product.all

    data = []
    @products.each do |p|
      temp = Competitor.new(name: p[:name],   brand: p[:brand], premium: Competitor.find_by(:tariff_id => @ctariff, :name => p.brand).premium)
      data << temp
    end

    g = PivotTable::Grid.new do |g|
      g.source_data  = data
      g.column_name  = :name
      g.row_name     = :brand
      g.field_name   = :premium
    end

    @pivot = g.build
  end

  def update_graph

    if params[:ctariff].to_i < Tariff.first.id
      @ctariff = Tariff.first.id
    elsif params[:ctariff].to_i > Tariff.last.id
      @ctariff = Tariff.last.id
    else
      @ctariff = params[:ctariff].to_i
    end
  end

  def dashboard2

    @products = Product.all
    @coefficients = Coefficient.all
    @tariffs = Tariff.all

    @prices = Product.where(tariff_id: @tariffs.first).pluck(:properties)
    @coefficient_keys = Coefficient.first.coefficients.keys
    @keys = Product.order("brand DESC").pluck(:brand).uniq

    @result = []

    @products.first.properties.each do |property|
      property.each do |key, value|
        #@coefficients.each do |c|
        #  temp = c.intercept + c.coefficients[key] * v[1]
        #end
        @result << key
      end
    end



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
    #@value = @pivot.rows.first.data[0]

    #@keys = Coefficient.uniq.pluck(:coefficient)
  end
end
