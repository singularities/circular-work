class Task
  # Methods required by clockwork to run tasks
  #
  # Clockwork tick is setup to run every hour, in "#{ Rails.root }/clock.rb"
  # At every hour, it will check if it has passed more time that the frequency
  # value, if the at value matches current time, and if the if? method is true
  module Clock
    # monthly -> 1.month
    def frequency
      # 1.send recurrence_sym.to_s[0..-3]
      # We only support weekly and monthly recurrence with weekly match by now
      1.week
    end

    # By now, we only run tasks mondays in the early morning
    def at
      "mon 05:**"
    end

    # We only support weekly and monthly recurrence with weekly match by now
    def if? time
      case recurrence_sym
      when :weekly
        true
      when :monthly
        recurrence_matches? time
      else
        false
      end
    end
  end
end
