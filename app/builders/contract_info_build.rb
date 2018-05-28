require 'nokogiri'
require 'open-uri'
require 'pry'

teams = Team.all
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

  contracts_array = []

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
    contracts_array << contract_hash
  end


  contracts_array.each do |contract|
    player = Player.find_by(first_name: contract["first_name"], last_name: contract["last_name"], team: team[1])
    if !player
      player = Player.find_by(last_name: contract["last_name"], team: team[1])
    end
    if !player
      player = Player.find_by(first_name: contract["first_name"], last_name: contract["last_name"])
    end
    if !player
      player = Player.find_by(first_name: contract["first_name"], position: contract["position"], team: team[1])
    end
    length = contract["contract_years"].to_i
    total = contract["contract_total"]
    aav = contract["aav"]
    guaranteed = contract["guaranteed"]
    expires = contract["expires"].to_i
    start_year = expires - length
    if player
      Contract.create!(
        player: player,
        team: team[1],
        length: length,
        total: total,
        aav: aav,
        guaranteed: guaranteed,
        start_year: start_year,
        expires: expires
      )
    end
  end
end
