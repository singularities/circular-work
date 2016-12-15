class TurnsController < ApplicationController
  before_action :set_turn, only: [:show, :update, :destroy]

  # GET /turns
  def index
    @turns = Turn.all

    render json: @turns
  end

  # GET /turns/1
  def show
    render json: @turn
  end

  # POST /turns
  def create
    @turn = Turn.new(turn_params)

    if @turn.save
      render json: @turn, status: :created, location: @turn
    else
      render_json_api_errors(@turn)
    end
  end

  # PATCH/PUT /turns/1
  def update
    if @turn.update(turn_params)
      render json: @turn
    else
      render_json_api_errors(@turn)
    end
  end

  # DELETE /turns/1
  def destroy
    @turn.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_turn
    @turn = Turn.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def turn_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: turn_valid_attributes)
  end

  def turn_valid_attributes
    [ 
      :task, :position, :groups
    ]
  end
end
