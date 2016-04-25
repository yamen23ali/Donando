class DemandsController < ApplicationController

  before_action :set_demand, only: [:show, :edit, :update, :destroy]

  respond_to :json

  # GET /demands
  # GET /demands.json
  def index
    @demands = Demand.all
  end

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

  # DELETE /demands/1
  # DELETE /demands/1.json
  def destroy
    @demand.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def search
    @demands = Demand.search( params['address'], params['filter'])
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
