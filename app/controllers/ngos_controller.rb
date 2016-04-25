class NgosController < ApplicationController

  before_action :set_ngo, only: [:show, :edit, :update, :destroy]

  respond_to :json

  # GET /ngos
  # GET /ngos.json
  def index
    @ngos = Ngo.all
  end

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

  # DELETE /ngos/1
  # DELETE /ngos/1.json
  def destroy
    @ngo.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

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
