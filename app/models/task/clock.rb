class Task
  # Methods required by clockwork to run tasks
  module Clock
    # monthly -> 1.month
    def frequency
      # 1.send recurrence_sym.to_s[0..-3]
      # We only support weekly and monthly recurrence with weekly match by now
      1.week
    end

    # By now, we only run tasks mondays in the early morning
    def at
      "mon 05:37"
    end
  end
end
