require 'rails_helper'

RSpec.describe Task, type: :model do
  fixtures :tasks

  let(:weekly_task)  { tasks(:weekly) }
  let(:monthly_task) { tasks(:monthly) }

  describe '.weekly' do
    it 'includes weekly tasks' do
      expect(Task.weekly).to include(weekly_task)
    end

    it 'does not include monthly tasks' do
      expect(Task.weekly).not_to include(monthly_task)
    end
  end

  describe '.monthly' do
    it 'includes monthly tasks' do
      expect(Task.monthly).to include(monthly_task)
    end

    it 'does not include weekly tasks' do
      expect(Task.monthly).not_to include(weekly_task)
    end

  end

  describe "rotate" do
    it "should move first turn to bottom" do
      # Confirm that we have more than 1 turn for the test
      expect(weekly_task.turns.count).to be > 1

      t = weekly_task.turns.first

      weekly_task.rotate

      expect(weekly_task.turns.first).not_to eql(t)
      expect(weekly_task.turns.last).to eql(t)
    end
  end
end
