class DemandsController < ApplicationController

  before_action :set_demand, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def_param_group :demands do
    param :demands, Hash do
      param :ngo_id, Integer, "The NGO id that this demand belongs for"
      param :data, String, "Demand description"
    end
  end

  api :GET, "/demands", "Get all demands"
  # GET /demands
  # GET /demands.json
  def index
    @demands = Demand.all
  end

  api :GET, "/demands/:id", "Get specific demand"
  # GET /demands/1
  # GET /demands/1.json
  def show
    puts @demand
  end

  # GET /demands/new
  def new
    @demand = Demand.new
  end

  # GET /demands/1/edit
  def edit
  end


  api :POST, "/demands", "Create new demand"
  param_group :demands
  # POST /demands
  # POST /demands.json
  def create
    @demand = Demand.new(demand_params)

    respond_to do |format|
      if @demand.save
        format.json { render :show, status: :created, location: @demand }
      else
        format.json { render json: @demand.errors, status: :unprocessable_entity }
      end
    end
  end

  api :PUT, "/demands", "Update existing demand"
  param_group :demands
  # PATCH/PUT /demands/1
  # PATCH/PUT /demands/1.json
  def update
    respond_to do |format|
      if @demand.update(demand_params)
        format.json { render :show, status: :ok, location: @demand }
      else
        format.json { render json: @demand.errors, status: :unprocessable_entity }
      end
    end
  end


  api :DELETE, "/demands", "Delete demand"
  # DELETE /demands/1
  # DELETE /demands/1.json
  def destroy
    @demand.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  api :GET, "/demands/search", "Search demands by address and filter"
  param :address, String, :desc => "Address to get all near by NGOs wihtin ( 100 km )"
  param :filter, String, :desc => "Space separated key words to search demand data for"
  param :size, Integer, :desc => "Page Size"
  param :page, Integer, :desc => "Page Number"
  def search
    size = ( params['size'].blank? ? 20 : params['size'].to_i  )
    page = ( params['page'].blank? ? 0 : params['page'].to_i  )

    @demands = Demand.search( params['address'], params['filter'], size, page)
  end

  def import
    if params['full_import'].blank?
      DataImportWorker.perform_async
    else
      Demand.import
    end

    respond_with {}
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_demand
      @demand = Demand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def demand_params
      params.require(:demand).permit(:ngo_id, :data)
    end
end
