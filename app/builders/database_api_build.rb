require 'net/http'
require 'pry'
require 'json'
# require 'dotenv-rails'

uri = URI('https://api.fantasydata.net/v3/nfl/stats/JSON/Teams')

request = Net::HTTP::Get.new(uri.request_uri)
# Request headers
request['Ocp-Apim-Subscription-Key'] = ENV['FANTASY_DATA_API_TOKEN']
request.body = "{body}"

response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
end

data = JSON.pretty_generate(JSON[response.body])

File.open('../app/builders/team_api.json', 'w') { |file| file.write(data) }

teams = ["ARI",
 "ATL",
 "BAL",
 "BUF",
 "CAR",
 "CHI",
 "CIN",
 "CLE",
 "DAL",
 "DEN",
 "DET",
 "GB",
 "HOU",
 "IND",
 "JAX",
 "KC",
 "LAC",
 "LAR",
 "MIN",
 "NE",
 "NO",
 "NYG",
 "NYJ",
 "OAK",
 "PHI",
 "PIT",
 "SF",
 "TB",
 "TEN",
 "WAS",
 "MIA",
 "SEA",
 "FA"]

teams.each do |team|
  uri = URI("https://api.fantasydata.net/v3/nfl/stats/JSON/Players/#{team}")

  request = Net::HTTP::Get.new(uri.request_uri)
  # Request headers
  request['Ocp-Apim-Subscription-Key'] = ENV['FANTASY_DATA_API_TOKEN']
  request.body = "{body}"

  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
  end

  data = JSON.pretty_generate(JSON[response.body])

  File.open("./app/builders/rosters/#{team}.json", 'w') { |file| file.write(data) }
end

uri = URI("https://api.fantasydata.net/v3/nfl/stats/JSON/FreeAgents")

request = Net::HTTP::Get.new(uri.request_uri)
# Request headers
request['Ocp-Apim-Subscription-Key'] = ENV['FANTASY_DATA_API_TOKEN']
request.body = "{body}"

response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
end

data = JSON.pretty_generate(JSON[response.body])

File.open("./app/builders/rosters/FA.json", 'w') { |file| file.write(data) }
