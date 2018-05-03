require 'net/http'
require 'pry'
require 'json'
require 'dotenv'

uri = URI('https://api.fantasydata.net/v3/nfl/stats/JSON/Teams')

request = Net::HTTP::Get.new(uri.request_uri)
# Request headers
request['Ocp-Apim-Subscription-Key'] = "4c53b2b9f2324c86a1cf1f7acaae24be"
request.body = "{body}"

response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
end

data = JSON.pretty_generate(JSON[response.body])

File.open('./team_api.json', 'w') { |file| file.write(data) }
