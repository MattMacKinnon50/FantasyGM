require 'net/http'
require 'pry'
require 'json'
# require 'dotenv-rails'

teams = Team.all

teams.each do |team|
  uri = URI("https://api.fantasydata.net/v3/nfl/stats/JSON/Players/#{team.abbr}")

  request = Net::HTTP::Get.new(uri.request_uri)
  # Request headers
  request['Ocp-Apim-Subscription-Key'] = FANTASY_DATA_API_TOKEN
  request.body = "{body}"

  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
  end

  data = JSON.pretty_generate(JSON[response.body])

  File.open("./app/builders/rosters/#{team.abbr}.json", 'w') { |file| file.write(data) }
end