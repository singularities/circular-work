class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: [ :index, :show ]

  # GET /tasks
  def index
    # Temporarily disabling task filtering, before we can asign
    # external people to tasks
    # @tasks = Task.for(current_user).includes(:turns)
    @tasks = Task.all.includes(:turns)

    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = current_user.authored_tasks.build(task_params)

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
    @task = Task.find(params[:id])
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
