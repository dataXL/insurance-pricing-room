class TariffsController < ApplicationController
  before_action :set_tariff, only: [:show, :edit, :update, :destroy]

  # GET /tariffs
  # GET /tariffs.json
  def index
    @tariffs = Tariff.order(:id)

    respond_to do |format|
      format.html
      format.csv { send_data @tariffs.to_csv(:col_sep => ";") }
    end
  end

  # GET /tariffs/1
  # GET /tariffs/1.json
  def show
    @header = Tariff.column_names
    @tariff = Tariff.find(params[:id])
  end

  # GET /tariffs/new
  def new
    @tariff = Tariff.new
  end

  # GET /tariffs/select
  def select

    ## Save file to tmp/files/
    @name = "#{Time.now.strftime("%Y%m%d%H%M%S")}_#{params[:file].original_filename}"
    directory = "tmp/files"
    path = File.join(directory, @name)
    File.open(path, "wb") { |f| f.write(params[:file].read) }

    file = File.open(path, 'r')

    spreadsheet = Tariff.open_spreadsheet(file)
    @header = spreadsheet.sheet(0).row(1)
  end

  # GET /tariffs/map
  def map
    # I18n.transliterate(filter).gsub(/\s/, '_').gsub(/[^0-9A-Za-z](_)/, '').downcase
  end

  # GET /tariffs/import
  def import

    file    = params[:file]
    filters = params[:filters]

    Tariff.import(file, filters)
  end

  # GET /tariffs/1/edit
  def edit
  end

  # POST /tariffs
  # POST /tariffs.json
  def create
    @tariff = Tariff.new(tariff_params)

    respond_to do |format|
      if @tariff.save
        format.html { redirect_to @tariff, notice: 'Tariff was successfully created.' }
        format.json { render :show, status: :created, location: @tariff }
      else
        format.html { render :new }
        format.json { render json: @tariff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tariffs/1
  # PATCH/PUT /tariffs/1.json
  def update
    @tariff = Tariff.find params[:id]

    respond_to do |format|
      if @tariff.update(tariff_params)
        format.html { redirect_to @tariff, notice: 'Tariff was successfully updated.' }
        format.json { respond_with_bip(@tariff) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@tariff) }
      end
    end
  end

  # DELETE /tariffs/1
  # DELETE /tariffs/1.json
  def destroy
    @tariff.destroy
    respond_to do |format|
      format.html { redirect_to tariffs_url, notice: 'Tariff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    ## Use callbacks to share common setup or constraints between actions.
    def set_tariff
      @tariff = Tariff.find(params[:id])
    end

    ## Never trust parameters from the scary internet, only allow the white list through.
    def tariff_params
      #params.require(:tariff).permit(:tariff, :properties, :segment)

      whitelist = [:tariff, :properties, :segment]

      Tariff.first.properties.each do |k,v|
        whitelist << k.to_sym
      end

      params.require(:tariff).permit(whitelist)
    end

    ## Test if string is number
    def is_number? string
      true if Float(string) rescue false
    end

    ## Test if string is number
    def is_integer? string
      true if Integer(string) rescue false
    end
end
