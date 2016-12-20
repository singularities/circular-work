class Task < ApplicationRecord
  RECURRENCE       = [ :daily, :weekly, :monthly, :yearly ]
  RECURRENCE_MATCH = /(-?[1-5]) ([1-7])/

  validates_presence_of :title, :recurrence
  validates_inclusion_of :recurrence, in: 0..(RECURRENCE.length - 1)
  validates_format_of :recurrence_match, with: RECURRENCE_MATCH, allow_blank: true

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :turns, -> { order(position: :asc) }
  has_many :users, through: :turns

  # Create a named_scope for each recurrence: dayly, weekly, etc..
  RECURRENCE.each_with_index do |name, index|
    scope name, -> {
      where(recurrence: index)
    }
  end

  scope :authored_by, ->(user) {
    where(author: user)
  }

  scope :with_member, ->(user) {
    joins(:users).where(users: { id: user.id })
  }

  scope :for, ->(user) {
    authored_by(user).or(where(id: with_member(user).ids))
  }

  def recurrence_sym
    RECURRENCE[recurrence]
  end

  # Array with: [ order, day of the week ]
  #
  # NOTE: RECURRENCE_MATCH is only implemented for weeks
  def recurrence_order_and_day
    RECURRENCE_MATCH.match(recurrence_match).captures.map{ |i| i.try(:to_i) }
  end

  # We only support recurrence matches in monthly tasks for now
  def recurrence_matches? time
    return false if recurrence_match.blank?

    order, day = recurrence_order_and_day

    # Calculate the date in this week that would match the recurrent_match.day
    recurrence_date_this_week = time.to_date + day - time.to_date.wday

    # Assert if recurrence_match.order matches the date in this week
    if order > 0
      order == (recurrence_date_this_week.mday / 7.0).ceil
    else
      order == ((recurrence_date_this_week - recurrence_date_this_week.next_month.beginning_of_month) / 7.0).floor
    end
  end

  def rotate
    return if turns.empty?

    turns.first.move_to_bottom
  end

  include Task::Notification
  include Task::Clock
end
