class Task < ApplicationRecord
  RECURRENCE       = [ :no_recurrence, :dayly, :weekly, :monthly, :yearly ]
  RECURRENCE_MATCH = /(-?[1-5]) ([1-7])/

  # Create a named_scope for each recurrence: dayly, weekly, etc..
  RECURRENCE.each_with_index do |name, index|
    scope name, -> {
      where(recurrence: index)
    }
  end

  validates_presence_of :title, :recurrence
  validates_inclusion_of :recurrence, :in => 0..(RECURRENCE.length - 1)
  validates_format_of :recurrence_match, :with => RECURRENCE_MATCH, :allow_blank => true

end
