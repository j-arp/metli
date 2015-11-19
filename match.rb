class Match
  has_one :home_team, class_name: 'Team', foriegn_key: 'home_team_id'
  has_one :away_team, class_name: 'Team', foriegn_key: 'away_team_id'

end
