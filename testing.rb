require 'minitest/spec'
require 'minitest/autorun'
require_relative 'program'

class Testing
  describe MatchScore do
    describe 'final score' do

      it 'Checking Get total points method' do
        result = MatchScore.new.get_total_points('sample-input.txt')
        assert_equal(result, { 'Tarantulas' => 6, 'Lions' => 5, 'FC Awesome' => 1, 'Snakes' => 1, 'Grouches' => 0 })
      end

      it 'Add points after a win' do
        total_points = { 'Tarantulas' => 6, 'Lions' => 5 }
        result = MatchScore.new.add_winning_points(total_points, 'Lions', 'Snakes')
        assert_equal(result.to_h, { 'Tarantulas' => 6, 'Lions' => 8, 'Snakes' => 0 })
      end

      it 'Add points for a tie' do
        total_points = { 'Tarantulas' => 4, 'Lions' => 2 }
        result = MatchScore.new.add_points_for_tie(total_points, 'Lions', 'Snakes')
        assert_equal(result.to_h, { 'Tarantulas' => 4, 'Lions' => 3, 'Snakes' => 1 })
      end
    end
  end
end
