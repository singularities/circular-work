class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: [ :index, :show ]

  # GET /organizations
  def index
    @organizations = Organization.all

    render json: @organizations
  end

  # GET /organizations/1
  def show
    render json: @organization
  end

  # POST /organizations
  def create
    @organization = current_user.authored_organizations.build(organization_params)

    if @organization.save
      render json: @organization, status: :created, location: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organizations/1
  def update
    if @organization.update(organization_params)
      render json: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  # DELETE /organizations/1
  def destroy
    @organization.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def organization_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: organization_valid_attributes)
  end

  def organization_valid_attributes
    [
      :name
    ]
  end
end
