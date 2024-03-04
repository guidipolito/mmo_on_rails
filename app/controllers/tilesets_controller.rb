class TilesetsController < ApplicationController
  before_action :set_tileset, only: %i[ show edit update destroy ]

  # GET /tilesets or /tilesets.json
  def index
    @tilesets = Tileset.all
  end

  # GET /tilesets/new
  def new
    @tileset = Tileset.new
  end

  # GET /tilesets/1/edit
  def edit
  end

  # POST /tilesets or /tilesets.json
  def create
    @tileset = Tileset.new(tileset_params)

    respond_to do |format|
      if @tileset.save
        format.html { redirect_to edit_tileset_url(@tileset), notice: "Tileset was successfully created." }
        format.json { render :show, status: :created, location: @tileset }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tileset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tilesets/1 or /tilesets/1.json
  def update
    respond_to do |format|
      if @tileset.update(tileset_params)
        format.html { redirect_to edit_tileset_url(@tileset), notice: "Tileset was successfully updated." }
        format.json { render :show, status: :ok, location: @tileset }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tileset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tilesets/1 or /tilesets/1.json
  def destroy
    @tileset.destroy

    respond_to do |format|
      format.html { redirect_to tilesets_url, notice: "Tileset was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tileset
      @tileset = Tileset.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tileset_params
      params.require(:tileset).permit(:name, :tilesize, :tiles, :image)
    end
end
