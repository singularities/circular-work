require 'rails_helper'

RSpec.describe Task::Clock, type: :model do
  fixtures :tasks

  let(:weekly_task)  { tasks(:weekly) }
  let(:monthly_task)  { tasks(:weekly) }

  describe "when asking for the frequency" do
    it "should be 1 week for weekly" do
      expect(weekly_task.frequency).to eq(1.week)
    end

    it "should be 1 week for monthly with recurrence_match" do
      expect(monthly_task.frequency).to eq(1.week)
    end
  end

  describe "when asking if running the task" do
    it "should be true for weekly" do
      expect(weekly_task.if?(Time.now)).to be(true)
    end

    it "should be true for monthly in the right date" do
      date = Date.new(2016, 10, 10)

      expect(weekly_task.if?(date)).to be(true)
    end

    it "should be false for monthly in the wrong date" do
      date = Date.new(2016, 10, 31)

      expect(weekly_task.if?(date)).to be(true)
    end
  end
end
