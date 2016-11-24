class Task < ApplicationRecord
  RECURRENCE       = [ :dayly, :weekly, :monthly, :yearly ]
  RECURRENCE_MATCH = /(-?[1-5]) ([1-7])/

  # Create a named_scope for each recurrence: dayly, weekly, etc..
  RECURRENCE.each_with_index do |name, index|
    scope name, -> {
      where(recurrence: index)
    }
  end

  validates_presence_of :title, :recurrence
  validates_inclusion_of :recurrence, in: 0..(RECURRENCE.length - 1)
  validates_format_of :recurrence_match, with: RECURRENCE_MATCH, allow_blank: true

  has_many :turns, -> { order(position: :asc) }

  def recurrence_sym
    RECURRENCE[recurrence]
  end

  def rotate
    return if turns.empty?

    turns.first.move_to_bottom
  end


  include Task::Notification
end
