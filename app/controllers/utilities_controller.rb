class UtilitiesController < ApplicationController
  before_action :set_utility, only: [:show, :edit, :update, :destroy]

  # GET /utilities
  # GET /utilities.json
  def index
    @utilities = Utility.all

    n = 10
    beta_0 = 1
    beta_1 = 0.25
    alpha = 0.05
    seed = 23423
    R.x = (1..n).entries
    R.eval <<EOF
      set.seed(#{seed})
      y <- #{beta_0} + #{beta_1}*x + rnorm(#{n})
      fit <- lm( y ~ x )
      est <- round(coef(fit),3)
      pvalue <- summary(fit)$coefficients[2,4]
EOF
    result = "E(y|x) ~= #{R.est[0]} + #{R.est[1]} * x"
    @test = R.eval "expand.grid(height = seq(60, 80, 5), weight = seq(100, 300, 50),
            sex = c('Male','Female'))"


    R.image_path = Rails.root.join("app", "assets","images","sample.png").to_s
    R.eval("numbers <- c(12,34,56,20,44,65)")
    R.eval("png(filename=image_path)")
    R.eval("require(stats)")
    R.eval("plot(cars)")
    R.eval("lines(lowess(cars))")
    R.eval("dev.off()")

  end

  # GET /utilities/1
  # GET /utilities/1.json
  def show
  end

  # GET /utilities/new
  def new
    @utility = Utility.new
  end

  # GET /utilities/1/edit
  def edit
  end

  # POST /utilities
  # POST /utilities.json
  def create
    @utility = Utility.new(utility_params)

    respond_to do |format|
      if @utility.save
        format.html { redirect_to @utility, notice: 'Utility was successfully created.' }
        format.json { render :show, status: :created, location: @utility }
      else
        format.html { render :new }
        format.json { render json: @utility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /utilities/1
  # PATCH/PUT /utilities/1.json
  def update
    respond_to do |format|
      if @utility.update(utility_params)
        format.html { redirect_to @utility, notice: 'Utility was successfully updated.' }
        format.json { render :show, status: :ok, location: @utility }
      else
        format.html { render :edit }
        format.json { render json: @utility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /utilities/1
  # DELETE /utilities/1.json
  def destroy
    @utility.destroy
    respond_to do |format|
      format.html { redirect_to utilities_url, notice: 'Utility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_utility
      @utility = Utility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def utility_params
      params[:utility]
    end
end
