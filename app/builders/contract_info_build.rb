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
    contract_hash["first_name"] = name_split[0]
    contract_hash["last_name"] = name_split[-1]
    contract_hash["position"] = contract.css("td")[1].text.strip
    contract_hash["age"] = contract.css("td")[2].text.strip
    contract_hash["experience"] = contract.css("td")[3].text.strip
    contract_hash["contract_years"] = contract.css("td")[4].css("span")[1].text.strip
    contract_hash["contract_total"] = contract.css("td")[4].css("span")[2].text.strip
    contract_hash["aav"] = contract.css("td")[5].text.strip
    contract_hash["guaranteed"] = contract.css("td")[6].text.strip
    contract_hash["expires"] = contract.css("td")[7].text.strip
    contracts_array << contract_hash
  end

  contracts_array.each do |contract|
    player = Player.find_by(first_name: contract["first_name"], last_name: contract["last_name"], team: team[1])
    length = contract["contract_years"].to_i
    total = contract["contract_total"]
    aav = contract["aav"]
    guaranteed = contract["guaranteed"]
    expires = contract["expires"].to_i
    start_year = expires - length
    Contract.create!(
      player: player,
      team: team[1],
      length: length,
      total: total,
      aav: aav,
      guaranteed: guaranteed,
      start_year: start_year
    )
  end
end
