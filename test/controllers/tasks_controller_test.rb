require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:weekly)
  end

  test "should get index" do
    get tasks_url, as: :json
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { description: @task.description, email: @task.email, notification_body: @task.notification_body, notification_subject: @task.notification_subject, recurrence: @task.recurrence, recurrence_match: @task.recurrence_match, title: @task.title } }, as: :json
    end

    assert_response 201
  end

  test "should show task" do
    get task_url(@task), as: :json
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: { task: { description: @task.description, email: @task.email, notification_body: @task.notification_body, notification_subject: @task.notification_subject, recurrence: @task.recurrence, recurrence_match: @task.recurrence_match, title: @task.title } }, as: :json
    assert_response 200
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(@task), as: :json
    end

    assert_response 204
  end
end
