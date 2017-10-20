class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: [ :show ]
  before_action :user_or_admin_or_token, only: [ :show ]
  before_action :organization_admin!, except: [ :index, :show, :create ]

  # GET /organizations
  def index
    @organizations = Organization.for(current_user).includes(:tasks, :groups, :admin_users)

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

  # Only render the organization when the authenticated user belongs to
  # the organization, or it is using the organization token
  def user_or_admin_or_token
    unless @organization.shows_to?(user: current_user, token: params[:token])
      render status: 403
    end
  end

  def organization_admin!
    unless @organization.admin_users.include? current_user
      render status: :forbidden
    end
  end

  # Only allow a trusted parameter "white list" through.
  def organization_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: organization_valid_attributes)
  end

  def organization_valid_attributes
    [
      :name,
      :"admin-emails"
    ]
  end
end
