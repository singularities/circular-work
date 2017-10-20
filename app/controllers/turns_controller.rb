class TurnsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_turn
  before_action :user_or_admin_or_token, only: [ :show ]
  before_action :organization_admin!, except: [ :show ]

  # GET /turns/1
  def show
    render json: @turn
  end

  # POST /turns
  def create
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
    @turn = action_name == 'create' ?
      Turn.new(turn_params) :
      Turn.find(params[:id])
  end

  # Only render the turn when the authenticated user belongs to
  # the organization, or it is using the organization token
  def user_or_admin_or_token
    unless @turn.organization.shows_to?(user: current_user, token: params[:token])
      render status: 403
    end
  end

  def organization_admin!
    unless @turn.admin_users.include? current_user
      render status: :forbidden
    end
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
