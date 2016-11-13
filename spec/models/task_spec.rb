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
end
