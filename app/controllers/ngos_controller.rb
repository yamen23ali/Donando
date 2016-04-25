class NgosController < ApplicationController

  before_action :set_ngo, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def_param_group :ngo do
    param :ngo, Hash do
      param :name, String, "NGO name"
      param :email, String, "NGO email"
      param :address, String, "NGO address"
      param :phone, String, "NGO phone"
    end
  end

  api :GET, "/ngos", "Get all Ngos"
  # GET /ngos
  # GET /ngos.json
  def index
    @ngos = Ngo.all
  end

  api :GET, "/ngos/:id", "Get specific Ngo"
  # GET /ngos/1
  # GET /ngos/1.json
  def show
  end

  # GET /ngos/new
  def new
    @ngo = Ngo.new
  end

  # GET /ngos/1/edit
  def edit
  end


  api :POST, "/ngos", "Create Ngo"
  param_group :ngo
  # POST /ngos
  # POST /ngos.json
  def create
   puts ngo_params
    @ngo = Ngo.new(ngo_params)

    respond_to do |format|
      if @ngo.save
        format.json { render :show, status: :created, location: @ngo }
      else
        format.json { render json: @ngo.errors, status: :unprocessable_entity }
      end
    end
  end

  api :PUT, "/ngos/:id", "Update Ngo data"
  param_group :ngo
  # PATCH/PUT /ngos/1
  # PATCH/PUT /ngos/1.json
  def update
    respond_to do |format|
      if @ngo.update(ngo_params)
        format.json { render :show, status: :ok, location: @ngo }
      else
        format.json { render json: @ngo.errors, status: :unprocessable_entity }
      end
    end
  end

  api :DELETE, "/ngos/:id", "Remove Ngo"
  # DELETE /ngos/1
  # DELETE /ngos/1.json
  def destroy
    @ngo.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  api :GET, "/ngos/near", "Get nearby NGOs"
  param :address, String, :desc => "Address to get all near by NGOs wihtin ( 100 km )"
  def near
    @ngos = Ngo.near(params['address'], 100, :units => :km)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ngo
      @ngo = Ngo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ngo_params
      params.require(:ngo).permit(:name, :address, :phone, :email)
    end
end
