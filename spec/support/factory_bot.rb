require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    name 'name'
    team_id '1'
  end

  factory :team do
    abbr 'JUN'
    city 'Juneau'
    name 'Huskies'
    logo 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Chicago_Bears_logo.svg'
    wordmark 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Chicago_Bears_logo.svg'
  end

  factory :player do
    sequence(:first_name) { |n| "Hingle #{n}" }
    sequence(:last_name) { |n| "McCringleberry #{n}" }
    sequence(:number) { |n| "#{n}"}
    position "WR"
    bye_week "1"
  end

end
