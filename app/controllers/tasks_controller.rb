class TasksController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_task, except: [ :index ]
  before_action :user_or_admin_or_token, only: [ :show ]
  before_action :organization_admin!, except: [ :index, :show ]

  # GET /tasks
  def index
    @tasks = Task.for(current_user).includes(:turns)

    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    if @task.save
      render json: @task, status: :created, location: @task
    else
      render_json_api_errors(@task)
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render_json_api_errors(@task)
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private

  def set_task
    @task = action_name == 'create' ?
      current_user.authored_tasks.build(task_params) :
      Task.find(params[:id])
  end

  # Only render the task when the authenticated user belongs to
  # the organization, or it is using the organization token
  def user_or_admin_or_token
    unless @task.organization.shows_to?(user: current_user, token: params[:token])
      render status: 403
    end
  end

  def organization_admin!
    unless @task.admin_users.include? current_user
      render status: :forbidden
    end
  end

  def task_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: task_valid_attributes)
  end

  def task_valid_attributes
    [
      :title, :description, :recurrence, :"recurrence-match",
      :"notification-email", :"notification-subject", :"notification-body",
      :organization
    ]
  end
end
