class UtilitiesController < ApplicationController
  before_action :set_utility, only: [:show, :edit, :update, :destroy]

  # GET /utilities
  # GET /utilities.json
  def index
    @utilities = Utility.all

    #R.x = (1..n).entries
    #y <- #{beta_0} + #{beta_1}*x + rnorm(#{n})
    #byebug

    R.eval <<EOF
      require 'DoE_base'
      oa.design(nfactors=4, nlevels=c(2,2,2,2),factor.names=lixo)
      lixo<-c('Categoria','Idade do condutor','Idade da carta', 'Sexo')
EOF

    puts R.lixo
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
