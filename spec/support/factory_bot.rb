require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    name 'name'
    team_id '1'
  end

sample_photo = 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Chicago_Bears_logo.svg'


  factory :team do
    abbr 'JUN'
    city 'Juneau'
    name 'Huskies'
    remote_logo_url sample_photo
    remote_wordmark_url sample_photo
  end

  factory :player do
    sequence(:first_name) { |n| "Hingle #{n}" }
    sequence(:last_name) { |n| "McCringleberry #{n}" }
    sequence(:number) { |n| "#{n}"}
    position "WR"
    bye_week "1"
  end

  factory :league do
    name "FantasyGM"
    display_name "FantasyGM"
    league_year 2018
    salary_cap 177200000
  end

end
