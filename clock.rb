require 'clockwork'
require 'clockwork/database_events'
require_relative './config/boot'
require_relative './config/environment'

module Clockwork
  # required to enable database syncing support
  Clockwork.manager = DatabaseEvents::Manager.new

  Clockwork.manager.configure do |config|
    # Decrease clockwork cicle to every hour, instead of 1 second
    # Our tasks have not such time requirements
    config[:sleep_timeout] = 1.hour
  end

  sync_database_events model: Task, every: 1.hour, thread: true do |task|

    # sync_database_events reads Tasks from the database and
    # creates events that will be run every task.frequency at
    # task.at
    #
    # When the right time comes, this block is executed

    task.rotate

    TaskMailer.notification(task).deliver_now
  end
end
