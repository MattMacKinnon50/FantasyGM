# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

file = File.read('./team_api.json')
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
