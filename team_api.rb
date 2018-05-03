require 'net/http'
require 'pry'
require 'json'
require 'dotenv'

uri = URI('https://api.fantasydata.net/v3/nfl/stats/JSON/Teams')

request = Net::HTTP::Get.new(uri.request_uri)
# Request headers
request['Ocp-Apim-Subscription-Key'] = ENV.fetch("FANTASY_DATA_API_TOKEN")
request.body = "{body}"

response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
end
binding.pry
# File.open('./team_api.json', 'w') { |file| file.write(response.body) }
