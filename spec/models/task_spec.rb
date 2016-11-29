require 'rails_helper'

RSpec.describe Task, type: :model do
  fixtures :tasks, :users

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

  describe "" do
    let(:pepe) { users(:pepe)}
    let(:lola) { users(:lola)}
    let(:maria) { users(:maria)}
    let(:monthly_with_author_only) { tasks(:monthly_with_author_only)}

    describe ".authored_by" do
      it "returns tasks owned and with that user as member" do
        expect(Task.authored_by(pepe)).to include(weekly_task)
      end

      it "does not return tasks with that user as member" do
        expect(Task.authored_by(lola)).not_to include(weekly_task)
      end

      it "returns tasks owned by a user" do
        expect(Task.authored_by(maria)).to include(monthly_with_author_only)
      end

    end

    describe ".with_member" do

      it "returns tasks owned and with that user as member" do
        expect(Task.with_member(pepe)).to include(weekly_task)
      end

      it "does not return tasks owned by a user" do
        expect(Task.with_member(maria)).not_to include(monthly_with_author_only)
      end

      it "returns tasks with that user as member" do
        expect(Task.with_member(lola)).to include(weekly_task)
      end
    end

    describe ".for" do

      it "returns tasks owned and with that user as member" do
        expect(Task.for(pepe)).to include(weekly_task)
      end

      it "returns tasks owned by a user" do
        expect(Task.for(maria)).to include(monthly_with_author_only)
      end

      it "returns tasks with that user as member" do
        expect(Task.for(lola)).to include(weekly_task)
      end
    end
  end

  describe "recurrence_sym" do
    it "returns the right symbol" do
      expect(weekly_task.recurrence_sym).to equal(:weekly)
    end
  end

  describe "#recurrence_order_and_day" do
    it "returns the right string" do
      expect(monthly_task.recurrence_order_and_day).to match([2, 2])
    end
  end

  describe "#recurrence_match?" do
    it "returns false in task without recurrence_match" do
      expect(weekly_task.recurrence_matches? Time.now).to be(false)
    end

    describe "when task has monthly recurrence" do

      it "returns true on monday of same week" do
        date = Date.new(2016, 11, 7)

        expect(monthly_task.recurrence_matches? date).to be(true)
      end

      it "returns false on monday of other week" do
        date = Date.new(2016, 11, 14)

        expect(monthly_task.recurrence_matches? date).to be(false)
      end
    end

    describe "when task has monthly recurrence and negative order" do
      let(:monthly_last_sunday_task) { tasks(:monthly_last_sunday) }

      it "returns true on monday of same week" do
        date = Date.new(2016, 11, 21)

        expect(monthly_last_sunday_task.recurrence_matches? date).to be(true)
      end

      it "returns false on monday of other week" do
        date = Date.new(2016, 11, 28)

        expect(monthly_last_sunday_task.recurrence_matches? date).to be(false)
      end
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

  describe ".author" do
    let(:pepe) { users(:pepe) }

    it 'returns the right user' do
      expect(weekly_task.author).to eq(pepe)
    end
  end
end
