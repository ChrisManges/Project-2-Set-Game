class Player
    attr_accessor :turn_time, :timer_start, :name

    # given a name, initializes the player object
    def initialize(name)
        @turn_time = 0
        @name = name.to_s.chomp
    end

    # starts the timer for the player's turn
    def turn_start
        @timer_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end

    # adds the time from the beginning of the player's turn to their total score
    def turn_end
        @turn_time += (Process.clock_gettime(Process::CLOCK_MONOTONIC) - @timer_start).to_i
    end

    # adds a penalty of 5 seconds (for an incorrect set guess)
    def penalty
        @turn_time += 5
    end
end