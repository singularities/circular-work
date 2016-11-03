require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "recurrence scopes" do
    assert_includes Task.weekly, tasks(:weekly)
    assert_not_includes Task.weekly, tasks(:monthly)
  end
end
