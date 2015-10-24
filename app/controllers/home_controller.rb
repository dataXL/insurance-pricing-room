class HomeController < ApplicationController

	def index
    render layout, "empty"
	end

  def dashboard
    @dictionary = [
        ['Football', 10],
        ['Basketball', 5],
        ['Basketball', 5],
        ['Basketball', 5],
        ['Basketball', 5]
    ]

    @barchart = [["Sun", 32],["Mon", 46],["Tue", 28]]

    # @data = [
    #     ['name','Workout', 'data', ['2013-02-10 00,00,00 -0800', 3, '2013-02-17 00,00,00 -0800', 4]],
    #     ['name','Call parents', 'data', ['2013-02-10 00,00,00 -0800', 5, '2013-02-17 00,00,00 -0800', 3]]
    # ]

    @data = [
        [1, 300],
        [2, 600],
        [3, 550],
        [4, 400],
        [5, 300]
    ]

    data_table = GoogleVisualr::DataTable.new

    # Add Column Headers
    data_table.new_column('string', 'Year' )
    data_table.new_column('number', 'Sales')
    data_table.new_column('number', 'Expenses')

    # Add Rows and Values
    data_table.add_rows([
                            ['ghjghj', 1000, 400],
                            ['ghjgj', 1170, 460],
                            ['2006', 660, 1120],
                            ['2007', 1030, 540]
                        ])



    option = { width: 400, height: 240, title: 'Company Performance' }

    @barchart = GoogleVisualr::Interactive::BarChart.new(data_table, option)


    @areachart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)

    @gaugechart = GoogleVisualr::Interactive::Gauge.new(data_table, option)


    @linechart = GoogleVisualr::Interactive::LineChart.new(data_table, option)


  end
end
