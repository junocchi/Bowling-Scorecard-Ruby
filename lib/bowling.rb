class Bowling
  attr_reader :score

  def initialize
    @score = 0
    @frame = 1
    @bonus_roll = 0
  end

  def process_frame(rolls)
    raise 'Game over.' if @frame > 10

    pins = 10

    # Calculates roll score
    rolls.each_with_index do |roll, index|
      pins -= roll
      @score += roll

      # Apply bonus from previous roll
      if @bonus_roll > 0
        consecutive_strikes = ((roll == 10) && (@bonus_roll == 2))
        bonus_multiplier = (consecutive_strikes ? 2 : 1)
        @score += (roll * bonus_multiplier)
        @bonus_roll -= 1
      end

      # Set bonus in case of strike or spare
      if (pins == 0) && (@frame < 10)
        @bonus_roll = (2 - index)
        break
      end
    end

    @frame += 1
  end

  def report_score
    if @score == 0
      "Game over, you scored 0 points."    
    elsif @score == 300
      "Congratulations on your perfect game! You scored 300 points!"
    else
      "You scored #{@score} points!"
    end
  end
end

## Tests
## ... describe, it
bowling = Bowling.new
bowling.process_frame([6, 4])
bowling.process_frame([1, 0])
puts "#{bowling.score} should be 12"

bowling = Bowling.new
bowling.process_frame([10])
bowling.process_frame([10])
bowling.process_frame([5, 3])
puts "#{bowling.score} should be 56"
## ...

bowling = Bowling.new
bowling.process_frame([1, 4])
bowling.process_frame([4, 5])
bowling.process_frame([6, 4])
bowling.process_frame([5, 5])
bowling.process_frame([10, 0])
bowling.process_frame([0, 1])
bowling.process_frame([7, 3])
bowling.process_frame([6, 4])
bowling.process_frame([10, 0])
bowling.process_frame([2, 8, 6])
puts "#{bowling.score} should be 133"

bowling = Bowling.new
bowling.process_frame([10])
bowling.process_frame([10])
bowling.process_frame([10])
bowling.process_frame([10])
bowling.process_frame([10])
bowling.process_frame([10])
bowling.process_frame([10])
bowling.process_frame([10])
bowling.process_frame([10])
bowling.process_frame([10, 10])
puts "#{bowling.score} should be 300"