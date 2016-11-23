class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [ :create ]

  # GET /tasks
  def index
    @tasks = Task.all

    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    @task.author = current_user

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

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def task_params
    params.require(:data).require(:attributes).permit(task_valid_attributes)
  end

  def task_valid_attributes
    [
      :title, :description, :recurrence, :recurrence_match, :email,
      :notification_subject, :notification_body
    ]
  end
end
