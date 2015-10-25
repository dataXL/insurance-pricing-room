class CodingsController < ApplicationController
  before_action :set_coding, only: [:show, :edit, :update, :destroy]

  # GET /codings
  # GET /codings.json
  def index
    @tariffs = Tariff.all

    connection = ActiveRecord::Base.connection
    quantitative = []
    categorical = []
    values = []
    Tariff.first.properties.each do |k,v|
      if v.is_a? String
        r1 = connection.select_all("SELECT properties->>'" + k + "' AS property FROM tariffs").rows
        categorical << r1 if r1.uniq.length > 1
      else
        r2 = connection.select_all("SELECT properties->>'" + k + "' AS property FROM tariffs").rows.flatten
        values << r2.collect{|s| s.to_i}
        quantitative << k
      end
    end

    temp = categorical.flatten.uniq
    rows = sequence(temp.length)

    @header = temp # | quantitative
    @rows =  rows # | values

    # @test = values

    #data_set = Daru::DataFrame.from_csv "logistic_mle.csv"
    #glm = Statsample::GLM.compute data_set, :y, :logistic, {constant: 1, algorithm: :mle}

    # Options hash specifying addition of an extra constants
    # vector all of whose values is '1' and also specifying
    # that the MLE algorithm is to be used.

    #@test = glm.coefficients
      #=> [0.3270, 0.8147, -0.4031,-5.3658]
    #puts glm.standard_error
      #=> [0.4390, 0.4270, 0.3819,1.9045]
    #puts glm.log_likelihood


    #p sequence(3) #=>[[0, 0, 0], [0, 0, 1], [0, 1, 0], [0, 1, 1], [1, 0, 0], [1, 0, 1], [1, 1, 0], [1, 1, 1]]
  end

  # GET /codings/1
  # GET /codings/1.json
  def show
  end

  # GET /codings/new
  def new
    @coding = Coding.new
  end

  # GET /codings/1/edit
  def edit
  end

  # POST /codings
  # POST /codings.json
  def create
    @coding = Coding.new(coding_params)

    respond_to do |format|
      if @coding.save
        format.html { redirect_to @coding, notice: 'Coding was successfully created.' }
        format.json { render :show, status: :created, location: @coding }
      else
        format.html { render :new }
        format.json { render json: @coding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codings/1
  # PATCH/PUT /codings/1.json
  def update
    respond_to do |format|
      if @coding.update(coding_params)
        format.html { redirect_to @coding, notice: 'Coding was successfully updated.' }
        format.json { render :show, status: :ok, location: @coding }
      else
        format.html { render :edit }
        format.json { render json: @coding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codings/1
  # DELETE /codings/1.json
  def destroy
    @coding.destroy
    respond_to do |format|
      format.html { redirect_to codings_url, notice: 'Coding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coding
      @coding = Coding.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coding_params
      params[:coding]
    end

    def sequence(n)
      [0, 1].repeated_permutation(n).to_a
    end
end
