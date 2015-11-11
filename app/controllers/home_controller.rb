class HomeController < ApplicationController
  # before_action :authenticate_user!, only: [:dashboard]

	def index
    render layout: "empty"
	end

  def dashboard

    @products = Product.all
    @coefficients = Coefficient.all


    @prices = [56260, 55331, 75220, 61882, 114736]
    @coefficient_keys = Coefficient.first.coefficients.keys
    @keys = Product.order("brand DESC").pluck(:brand).uniq

    @result = []

    @products.each do |p|
      p.properties.each do |k,v|
        @coefficients.each do |c|
          @result << c.intercept + c.coefficients[k] * v[1]
        end
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
