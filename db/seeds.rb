# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

League.create!(
  name: "FantasyGM",
  display_name: "FantasyGM",
  league_year: 2018,
  salary_cap: 177200000
)

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
    primary_color: "#" + team["PrimaryColor"],
    secondary_color: "#" + team["SecondaryColor"],
    tertiary_color: "#" + team["TertiaryColor"],
    quaternary_color: "#" + team["QuaternaryColor"],
    remote_logo_url: team["WikipediaLogoUrl"],
    remote_wordmark_url: team["WikipediaWordMarkUrl"],
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
mia.remote_logo_url = "https://vignette.wikia.nocookie.net/logopedia/images/3/37/Miami_Dolphins_logo.svg/revision/latest?cb=20130822155430"
sea.remote_logo_url = "http://www.freelogovectors.net/wp-content/uploads/2018/03/seattle_seahawks_logo.png"
mia.save
sea.save

fa = Team.create(
  abbr: "FA",
  city: "Free",
  name: "Agent",
  remote_logo_url: "https://upload.wikimedia.org/wikipedia/en/thumb/a/a2/National_Football_League_logo.svg/358px-National_Football_League_logo.svg.png",
  remote_wordmark_url: "https://i2.wp.com/copelandcoaching.com/wp-content/uploads/2015/10/image.jpeg",
  primary_color: "#233E6F",
  secondary_color: "#D30614")
teams = Team.all
abbr_array = []

teams.each do |team|
  abbr_array << [team.abbr, team]
end

abbr_array.each do |org|
  file = File.read("./app/builders/rosters/#{org[0]}.json")
  data = JSON.parse(file)
  data.each do |player|
    if player["Position"] != nil
      stats17 = nil
      statsppr17 = nil
      college_draft_team = player["CollegeDraftTeam"]
      college_draft_round = nil
      ps_eligibility = false
      if player["PlayerSeason"] != nil
        stats17 = player["PlayerSeason"]["FantasyPoints"]
        statsppr17 = player["PlayerSeason"]["FantasyPointsPPR"]
      end
      if player["Experience"] && player["Experience"] <= 2
        ps_eligibility = true
      end
      if college_draft_team == "ARZ"
        college_draft_team = "ARI"
      elsif college_draft_team == "ARZ FA"
        college_draft_team = "ARI FA"
      elsif college_draft_team == "ARZ Supp"
        college_draft_team = "ARI Supp"
      elsif college_draft_team == "BA"
        college_draft_team = "BAL"
      elsif college_draft_team == "NUJ"
        college_draft_team = "NYJ"
      elsif college_draft_team == "Â IND"
        college_draft_team = "IND"
      elsif college_draft_team == "PHI  FA"
        college_draft_team = "PHI FA"
      elsif college_draft_team == "SL"
        college_draft_team = "STL"
      elsif college_draft_team == "SL FA"
        college_draft_team = "STL FA"
      elsif college_draft_team == "SL Supp"
        college_draft_team = "STL Supp"
      elsif college_draft_team == "LA FA"
        college_draft_team = "LAR FA"
      end
      if player["IsUndraftedFreeAgent"] && player["CollegeDraftRound"]
        college_draft_round = "#{player["CollegeDraftRound"]}S"
      else
        college_draft_round = player["CollegeDraftRound"]
      end
      height = 0.0
      if player["HeightFeet"] != nil
        height = player["HeightFeet"] + (player["HeightInches"]/12.0)
      else
        height = nil
      end
      Player.create!(
        team: org[1],
        nfl_team: player["Team"],
        number: player["Number"],
        first_name: player["FirstName"],
        last_name: player["LastName"],
        position: player["Position"],
        height: player["Height"],
        height_feet: height,
        weight: player["Weight"],
        birth_date: player["BirthDate"],
        college: player["College"],
        experience: player["Experience"],
        photo_url: player["PhotoUrl"],
        bye_week: player["ByeWeek"],
        college_draft_team: college_draft_team,
        college_draft_year: player["CollegeDraftYear"],
        college_draft_round: college_draft_round,
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

end

admin = User.create(
  email: "admin@email.com",
  password: "password",
  password_confirmation: "password",
  team_id: 21,
  admin: true
)

user_teams = []
teams.each do |team|
  if team.abbr != "FA"
    user_teams << [team.name, team.id]
  end
end

user_teams.each do |team|
  User.create(
    email: "#{team[0]}GM@email.com",
    password: "password",
    password_confirmation: "password",
    team_id: team[1]
  )
end

teams = Team.where.not(abbr: "FA")
league = League.first

teams_array = []

teams.each do |team|
  team_name = team.full_name.downcase.gsub(/[ ]/, '-')
  teams_array << [team_name, team]
end

teams_array.each do |team|
  contract_url = "http://www.spotrac.com/nfl/#{team[0]}/contracts/"
  page = Nokogiri::HTML(open(contract_url))
  contract_items = page.css("tr")
  contract_items.shift

  contract_items.each do |contract|
    contract_hash = {}
    contract_hash["name"] = contract.css("td")[0].css("a")[0].text.strip
    name_split = contract_hash["name"].split(" ")
    first_name = name_split[0].gsub(".", "")
    last_name = name_split[-1]
    if first_name == "Jarrod" && last_name == "Clements"
      first_name = "Chunky"
    elsif first_name == "DeAndre" && last_name == "Elliot"
      first_name = "Deandre"
    elsif first_name == "Buddy" && last_name == "Howell"
      first_name = "Gregory"
      last_name = "Howell Jr."
    end
    contract_hash["first_name"] = first_name
    if name_split.length != 2
      last_name = "#{name_split[-2]} #{name_split[-1]}"
    end
    if last_name == "Kumerov"
      last_name = "Kumerow"
    elsif last_name == "Shockely"
      last_name = "Shockley"
    elsif last_name == "Ellerbe"
      last_name = "Ellerbee"
    elsif last_name == "Haasenuaer"
      last_name = "Hassenauer"
    elsif last_name == "Corbet"
      last_name = "Corbett"
    elsif last_name == "LeBlanc"
      last_name = "Leblanc"
    elsif last_name == "Ejofor"
      last_name = "Ejiofor"
    elsif last_name == "Walker Jr."
      last_name = "Walker"
    elsif last_name == "Mickell"
      last_name = "Mikell"
    elsif last_name == "Adam"
      last_name = "Adams"
    elsif first_name == "Kacy" && last_name == "Rodgers"
      last_name = "Rodgers II"
    elsif first_name == "Greg" && last_name == "Ward"
      last_name = "Ward Jr"
    elsif last_name == "Magnunson"
      last_name = "Magnuson"
    end
    contract_hash["last_name"] = last_name
    position = contract.css("td")[1].text.strip
    if position == "T"
      position = "OT"
    end
    contract_hash["position"] = position
    contract_hash["age"] = contract.css("td")[2].text.strip
    contract_hash["experience"] = contract.css("td")[3].text.strip
    contract_hash["contract_years"] = contract.css("td")[4].css("span")[1].text.strip
    contract_hash["contract_total"] = contract.css("td")[4].css("span")[2].text.strip
    contract_hash["aav"] = contract.css("td")[5].text.strip
    contract_hash["guaranteed"] = contract.css("td")[6].text.strip
    contract_hash["expires"] = contract.css("td")[7].text.strip
    contract_hash["team"] = team[1].abbr
    player = Player.find_by(first_name: contract_hash["first_name"], last_name: contract_hash["last_name"], team: team[1])
    if !player
      player = Player.find_by(last_name: contract_hash["last_name"], team: team[1])
    end
    if !player
      player = Player.find_by(first_name: contract_hash["first_name"], last_name: contract_hash["last_name"])
    end
    if !player
      player = Player.find_by(first_name: contract_hash["first_name"], position: contract_hash["position"], team: team[1])
    end
    length = contract_hash["contract_years"].to_i
    total = 0
    if contract_hash["contract_total"] != "-"
      total = contract_hash["contract_total"].gsub(/[$,]/, '').to_f
      total.modulo(1) == 0 ? total.to_i : sprintf("%.2f", result)
    end
    aav = 0
    if contract["aav"] != "-"
      aav = contract_hash["aav"].gsub(/[$,]/, '').to_f
      aav.modulo(1) == 0 ? aav.to_i : sprintf("%.2f", result)
    end
    guaranteed = 0
    if contract["guaranteed"] != "-"
      guaranteed = contract_hash["guaranteed"].gsub(/[$,]/, '').to_f
      guaranteed.modulo(1) == 0 ? guaranteed.to_i : sprintf("%.2f", result)
    end
    expires = contract["expires"].to_i
    start_year = expires - length
    if start_year == 2019
      length++
      start_year = expires - length
    end

    if player
      Contract.create!(
        player: player,
        player_name: player.name,
        team: team[1],
        length: length,
        total: total,
        aav: aav,
        guaranteed: guaranteed,
        start_year: start_year,
        expires: expires
      )
    end

    # dead_money_url = "http://www.spotrac.com/nfl/#{team[0]}/cap/"
    # page = Nokogiri::HTML(open(dead_money_url))
    # dead_money_table = page.css("table")[-3]
    # dead_money_items = dead_money_table.css("tr")
    # dead_money_items.shift
    #
    #
    # dead_money_items.each do |dead_money|
    #   name = dead_money.css("td")[0].css("a")[0].text.strip
    #   name_split = name.split(" ")
    #   first_name = name_split[0].gsub(".", "")
    #   last_name = name_split[-1]
    #   if name_split.length != 2
    #     last_name = "#{name_split[-2]} #{name_split[-1]}"
    #   end
    #   if first_name == "Adam-Pacman"
    #     first_name = "Adam"
    #   elsif first_name == "Dominque" && last_name == "Alexander"
    #     first_name == "Dominique"
    #   elsif last_name == "Ivie"
    #     last_name = "Ivie IV"
    #   elsif first_name == "Pat" && last_name == "O'Connor"
    #     first_name = "Patrick"
    #   elsif first_name == "Des" && last_name == "Lawrence"
    #     first_name = "Desmond"
    #   elsif first_name == "Matt" && last_name == "Godin"
    #     first_name = "Matthew"
    #   elsif first_name == "Devante" && last_name == "Harris"
    #     first_name = "De'Vante"
    #   elsif first_name == "Benjamin" && last_name == "Ijalana"
    #     first_name = "Ben"
    #   elsif first_name == "Nate" && last_name == "Gerry"
    #     first_name = "Nathan"
    #   elsif first_name == "Tre'"
    #     first_name = "Tre"
    #   elsif first_name == "Greg" && last_name == "Ward"
    #     last_name == "Ward Jr"
    #   elsif first_name == "Navorro"
    #     first_name = "NaVorro"
    #   elsif first_name == "Michael" && last_name == "Tyson"
    #     first_name = "Mike"
    #   end
    #   position = dead_money.css("td")[1].text.strip
    #   if position == "T"
    #     position = "OT"
    #   end
    #   amount = dead_money.css("td")[10].text.strip
    #   amount = amount.gsub(/[$,]/, '').to_f
    #   amount.modulo(1) == 0 ? amount.to_i : sprintf("%.2f", result)
    #   amount = amount
    #   player = Player.find_by(first_name: first_name, last_name: last_name, position: position)
    #   if !player
    #     first_name_edit = first_name.downcase
    #     first_name_edit = first_name_edit.titleize
    #     if first_name_edit.length == 2 && first_name_edit[-1] == "j"
    #       first_name_edit = first_name_edit.upcase
    #     end
    #     player = Player.find_by(first_name: first_name_edit, last_name: last_name, position: position)
    #   end
    #   if !player
    #     player = Player.find_by(first_name: first_name_edit, last_name: last_name)
    #   end
    #   if !player
    #     last_name_edit = last_name.downcase
    #     last_name_edit = last_name_edit.titleize
    #     player = Player.find_by(first_name: first_name, last_name: last_name_edit, position: position)
    #   end
    #   if !player
    #     player = Player.find_by(first_name: first_name, last_name: last_name_edit)
    #   end
    #   if !player
    #     DeadMoney.create(
    #       team_id: team[1].id,
    #       name: name,
    #       year: league.league_year,
    #       amount: amount
    #       )
    #     else
    #       DeadMoney.create(
    #         team_id: team[1].id,
    #         player_id: player.id,
    #         name: player.name,
    #         year: league.league_year,
    #         amount: amount
    #         )
    #     end
    # end
  end
end
