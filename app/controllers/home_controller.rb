class HomeController < ApplicationController
  # before_action :authenticate_user!, only: [:dashboard]

	def index
    render layout: "empty"
	end

  def dashboard

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
