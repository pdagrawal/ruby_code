# get ranking of teams
class MatchScore
  def get_team_ranking
    total_points = get_total_points('sample-input.txt')
    print_data(total_points)
  end

  def get_total_points(input_file_name)
    total_points = {}
    File.open(input_file_name, 'r') do |file|
      file.each_line do |match_row|
        match_scores = {}
        match_row.chomp.split(', ').each do |team_with_score|
          score = team_with_score.split(' ').last.to_i
          team_name = team_with_score.chomp(' ' + score.to_s)
          match_scores[team_name] = score
        end
        team_a = match_scores.to_a[0]
        team_b = match_scores.to_a[1]
        if team_a[1] > team_b[1]
          total_points = add_winning_points(total_points, team_a[0], team_b[0])
        elsif team_a[1] < team_b[1]
          total_points = add_winning_points(total_points, team_b[0], team_a[0])
        elsif team_a[1] == team_b[1]
          total_points = add_points_for_tie(total_points, team_a[0], team_b[0])
        end
      end
    end
    total_points
  end

  def add_winning_points(total_points, won_team_name, loose_team_name)
    if total_points.key?(won_team_name)
      total_points[won_team_name] += 3
    else
      total_points[won_team_name] = 3
    end
    unless total_points.key?(loose_team_name)
      total_points[loose_team_name] = 0
    end
    total_points
  end

  def add_points_for_tie(total_points, team1, team2)
    [team1, team2].each do |team_name|
      if total_points.key?(team_name)
        total_points[team_name] += 1
      else
        total_points[team_name] = 1
      end
    end
    total_points
  end

  def print_data(total_points)
    previous_team_score = nil
    printable_rank = 1
    sorted_results = total_points.sort_by { |x, y| [-Integer(y), x] }
    sorted_results.each_with_index do |team_data, rank|
      point_string = team_data[1] == 1 ? ' pt' : ' pts'
      if previous_team_score.nil? || team_data[1] != previous_team_score
        printable_rank = rank + 1
      end
      puts printable_rank.to_s + '.' + team_data[0] + ', ' + team_data[1].to_s + point_string
      previous_team_score = team_data[1]
    end
  end
end

obj = MatchScore.new
obj.get_team_ranking
