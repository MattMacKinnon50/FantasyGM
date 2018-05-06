require 'net/http'
require 'pry'
require 'json'
# require 'dotenv-rails'

teams = Team.all

teams.each do |team|
  uri = URI("https://api.fantasydata.net/v3/nfl/stats/JSON/Players/#{team.abbr}")

  request = Net::HTTP::Get.new(uri.request_uri)
  # Request headers
  request['Ocp-Apim-Subscription-Key'] = '4c53b2b9f2324c86a1cf1f7acaae24be'
  request.body = "{body}"

  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
  end

  data = JSON.pretty_generate(JSON[response.body])
  json = File.read('./test_api.json')

  File.open('./test_api.json', 'a') do |f|
    f.puts JSON.pretty_generate(JSON.parse(json) << data)
  end
end
