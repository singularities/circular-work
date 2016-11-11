class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

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

    if @task.save
      render json: @task, status: :created, location: @task
    else
      # probably we should move this to some kind of helper / lib
      render json: @task, status: :unprocessable_entity,
            adapter: :json_api,
            serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
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
