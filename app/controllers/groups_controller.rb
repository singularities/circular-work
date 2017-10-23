class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_group
  before_action :user_or_admin_or_token, only: [ :show ]
  before_action :organization_admin!, except: [ :show ]

  # GET /groups/1
  def show
    render json: @group
  end

  # POST /groups
  def create
    if @group.save
      render json: @group, status: :created, location: @group
    else
      render_json_api_errors(@group)
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      render json: @group
    else
      render_json_api_errors(@group)
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = action_name == 'create' ?
      Group.new(group_params) :
      Group.find(params[:id])
  end

  # Only render the group when the authenticated user belongs to
  # the organization, or it is using the organization token
  def user_or_admin_or_token
    unless @group.organization.shows_to?(user: current_user, token: params[:token])
      render status: (user_signed_in? ? :forbidden : :unauthorized)
    end
  end

  def organization_admin!
    unless @group.admin_users.include? current_user
      render status: :forbidden
    end
  end

  # Only allow a trusted parameter "white list" through.
  def group_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: group_valid_attributes)
  end

  def group_valid_attributes
    [
      :name, :emails,
      :organization
    ]
  end

end
