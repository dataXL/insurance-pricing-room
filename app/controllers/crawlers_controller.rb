class CrawlersController < ApplicationController
  before_action :set_crawler, only: [:show, :edit, :update, :destroy]

  # GET /crawlers
  # GET /crawlers.json
  def index
    @crawlers = Crawler.order(:id)
  end

  # GET /crawlers/1
  # GET /crawlers/1.json
  def show
    @crawler = Crawler.find(params[:id])
  end

  def click
    @crawler = Crawler.find(params[:crawler])
    #format.html { redirect_to @crawler, notice: 'One more click.' }
  end

  def purchase
    @crawler = Crawler.find(params[:id])
    format.html { redirect_to @crawler, notice: 'One more purchase.' }
  end

  # GET /crawlers/new
  def new
    @crawler = Crawler.new
  end

  # GET /crawlers/1/edit
  def edit
  end

  # POST /crawlers
  # POST /crawlers.json
  def create
    @crawler = Crawler.new(crawler_params)

    respond_to do |format|
      if @crawler.save
        format.html { redirect_to @crawler, notice: 'Crawler was successfully created.' }
        format.json { render :show, status: :created, location: @crawler }
        format.js   { render nothing: true }
      else
        format.html { render :new }
        format.json { render json: @crawler.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crawlers/1
  # PATCH/PUT /crawlers/1.json
  def update
    respond_to do |format|
      if @crawler.update(crawler_params)
        format.html { redirect_to @crawler, notice: 'Crawler was successfully updated.' }
        format.json { render :show, status: :ok, location: @crawler }
        format.js   { render nothing: true }
      else
        format.html { render :edit }
        format.json { render json: @crawler.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crawlers/1
  # DELETE /crawlers/1.json
  def destroy
    @crawler.destroy
    respond_to do |format|
      format.html { redirect_to crawlers_url, notice: 'Crawler was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crawler
      @crawler = Crawler.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crawler_params
      params.require(:crawler).permit(:crawler, :clicks_performed_by_user, :purchases_performed_by_user)
    end
end
