require 'net/http'
require 'pry'
require 'json'

teams = Team.where.not(abbr: "FA")
teams_array = []

teams.each do |team|
  team_name = team.full_name.downcase.gsub(/[ ]/, '-')
  teams_array << [team_name, team]
end

no_player = []
yes_player = []

teams_array.each do |team|
  dead_money_url = "http://www.spotrac.com/nfl/#{team[0]}/cap/"
  page = Nokogiri::HTML(open(dead_money_url))
  dead_money_table = page.css("table")[-3]
  dead_money_items = dead_money_table.css("tr")
  dead_money_items.shift


  dead_money_items.each do |dead_money|
    name = dead_money.css("td")[0].css("a")[0].text.strip
    name_split = name.split(" ")
    first_name = name_split[0].gsub(".", "")
    last_name = name_split[-1]
    if name_split.length != 2
      last_name = "#{name_split[-2]} #{name_split[-1]}"
    end
    if first_name == "Adam-Pacman"
      first_name = "Adam"
    elsif first_name == "Dominque" && last_name == "Alexander"
      first_name == "Dominique"
    elsif last_name == "Ivie"
      last_name = "Ivie IV"
    elsif first_name == "Pat" && last_name == "O'Connor"
      first_name = "Patrick"
    elsif first_name == "Des" && last_name == "Lawrence"
      first_name = "Desmond"
    elsif first_name == "Matt" && last_name == "Godin"
      first_name = "Matthew"
    elsif first_name == "Devante" && last_name == "Harris"
      first_name = "De'Vante"
    elsif first_name == "Benjamin" && last_name == "Ijalana"
      first_name = "Ben"
    elsif first_name == "Nate" && last_name == "Gerry"
      first_name = "Nathan"
    elsif first_name == "Tre'"
      first_name = "Tre"
    elsif first_name == "Greg" && last_name == "Ward"
      last_name == "Ward Jr"
    elsif first_name == "Navorro"
      first_name = "NaVorro"
    elsif first_name == "Michael" && last_name == "Tyson"
      first_name = "Mike"
    end
    position = dead_money.css("td")[1].text.strip
    if position == "T"
      position = "OT"
    end
    amount = dead_money.css("td")[10].text.strip
    amount = amount.gsub(/[$,]/, '').to_f
    amount.modulo(1) == 0 ? amount.to_i : sprintf("%.2f", result)
    amount = amount
    player = Player.find_by(first_name: first_name, last_name: last_name, position: position)
    if !player
      first_name = first_name.downcase
      first_name = first_name.titleize
      if first_name.length == 2 && first_name[-1] == "j"
        first_name = first_name.upcase
      end
      player = Player.find_by(first_name: first_name, last_name: last_name, position: position)
    end
    if !player
      player = Player.find_by(first_name: first_name, last_name: last_name)
    end
    if !player
      last_name = last_name.downcase
      last_name = last_name.titleize
      player = Player.find_by(first_name: first_name, last_name: last_name, position: position)
    end
    if !player
      player = Player.find_by(first_name: first_name, last_name: last_name)
    end
  end
end
