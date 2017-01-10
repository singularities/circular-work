class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy]

  # GET /groups
  def index
    @groups = Group.all

    render json: @groups
  end

  # GET /groups/1
  def show
    render json: @group
  end

  # POST /groups
  def create
    @group = Group.new(group_params)

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
    @group = Group.find(params[:id])
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
