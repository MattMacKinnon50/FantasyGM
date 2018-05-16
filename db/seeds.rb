# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

file = File.read('./app/builders/team_api.json')
data = JSON.parse(file)


data.each do |team|
  Team.create!(
    abbr: team["Key"],
    city: team["City"],
    name: team["Name"],
    conference: team["Conference"],
    division: team["Division"],
    head_coach: team["HeadCoach"],
    offensive_coordinator: team["OffensiveCoordinator"],
    defensive_coordinator: team["DefensiveCoordinator"],
    special_teams_coach: team["SpecialTeamsCoach"],
    primary_color: team["PrimaryColor"],
    secondary_color: team["SecondaryColor"],
    tertiary_color: team["TertiaryColor"],
    quaternary_color: team["QuaternaryColor"],
    wikipedia_logo_url: team["WikipediaLogoUrl"],
    wikipedia_wordmark_url: team["WikipediaWordMarkUrl"],
    stadium_name: team["StadiumDetails"]["Name"],
    stadium_city: team["StadiumDetails"]["City"],
    stadium_state: team["StadiumDetails"]["State"],
    stadium_country: team["StadiumDetails"]["Country"],
    stadium_capacity: team["StadiumDetails"]["Capacity"],
    stadium_playing_surface: team["StadiumDetails"]["PlayingSurface"]
  )
end

mia = Team.find(19)
sea = Team.find(28)
mia.wikipedia_logo_url = "https://vignette.wikia.nocookie.net/logopedia/images/3/37/Miami_Dolphins_logo.svg/revision/latest?cb=20130822155430"
sea.wikipedia_logo_url = "http://www.freelogovectors.net/wp-content/uploads/2018/03/seattle_seahawks_logo.png"
mia.save
sea.save

fa = Team.create(
  abbr: "FA",
  city: "Free",
  name: "Agent",
  wikipedia_logo_url: "https://upload.wikimedia.org/wikipedia/en/thumb/a/a2/National_Football_League_logo.svg/358px-National_Football_League_logo.svg.png",
  wikipedia_wordmark_url: "https://i2.wp.com/copelandcoaching.com/wp-content/uploads/2015/10/image.jpeg",
  primary_color: "233E6F",
  secondary_color: "D30614")
teams = Team.all
abbr_array = []

teams.each do |team|
  abbr_array << [team.abbr, team]
end

abbr_array.each do |org|
  file = File.read("./app/builders/rosters/#{org[0]}.json")
  data = JSON.parse(file)
  data.each do |player|
    stats17 = nil
    statsppr17 = nil
    ps_eligibility = false
    if player["PlayerSeason"] != nil
      stats17 = player["PlayerSeason"]["FantasyPoints"]
      statsppr17 = player["PlayerSeason"]["FantasyPointsPPR"]
    end
    if player["experience"] <= 2
      ps_eligibility = true
    end

    Player.create!(
      team: org[1],
      nfl_team: player["Team"],
      number: player["Number"],
      first_name: player["FirstName"],
      last_name: player["LastName"],
      position: player["Position"],
      height: player["Height"],
      weight: player["Weight"],
      birth_date: player["BirthDate"],
      college: player["College"],
      experience: player["Experience"],
      photo_url: player["PhotoUrl"],
      bye_week: player["ByeWeek"],
      college_draft_team: player["CollegeDraftTeam"],
      college_draft_year: player["CollegeDraftYear"],
      college_draft_round: player["CollegeDraftRound"],
      college_draft_pick: player["CollegeDraftPick"],
      undrafted_free_agent_status: player["IsUndraftedFreeAgent"],
      fantasy_alarm_player_id: player["FantasyAlarmPlayerID"],
      sports_radar_player_id: player["SportRadarPlayerID"],
      rotoworld_player_id: player["RotoworldPlayerID"],
      rotowire_player_id: player["RotoWirePlayerID"],
      stats_player_id: player["StatsPlayerID"],
      sports_direct_player_id: player["SportsDirectPlayerID"],
      xmlteam_player_id: player["XmlTeamPlayerID"],
      fanduel_player_id: player["FanDuelPlayerID"],
      draftkings_player_id: player["DraftKingsPlayerID"],
      yahoo_player_id: player["YahooPlayerID"],
      fantasydraft_player_id: player["FantasyDraftPlayerID"],
      fantasy_stats_2017: stats17,
      fantasy_stats_ppr_2017: statsppr17,
      ps_eligibility: ps_eligibility
    )
  end

end

admin = User.create(
  email: "admin@fakeemail.com",
  password: "password",
  password_confirmation: "password",
  team_id: 21,
  admin: true
)
