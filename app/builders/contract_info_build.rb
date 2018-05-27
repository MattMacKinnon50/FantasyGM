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
  contract_url = 'http://www.spotrac.com/nfl/#{team[0]}/contracts/'
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

  
end
