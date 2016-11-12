require 'rails_helper'

RSpec.describe Task, type: :model do
  fixtures :tasks

  describe '.weekly' do
    let(:weekly_task) { tasks(:weekly) }

    it 'includes weekly tasks' do
      expect(Task.weekly).to include(weekly_task)
    end
  end

  describe '.monthly' do
    let(:monthly_task) { tasks(:monthly) }

    it 'includes monthly tasks' do
      expect(Task.monthly).to include(monthly_task)
    end
  end
end
