require 'rails_helper'

feature 'user views a team index page' do
  let!(:fa) {Team.create!(id: 33, abbr: "FA", city: "Free", name: "Agent")}
  let!(:player1) {FactoryBot.create(:player, team: fa)}
  let!(:player2) {FactoryBot.create(:player, position: "QB", team: fa)}
  let!(:player3) {FactoryBot.create(:player, position: "RB", team: fa)}

  scenario "user views free agent list" do
    visit "/teams/#{fa.id}"
    
    expect(page).to have_content("Free Agents")

    expect(page).to have_content(player1.name)
    expect(page).to have_content(player1.number)
    expect(page).to have_content(player1.position)
    expect(page).to have_content(player2.name)
    expect(page).to have_content(player2.number)
    expect(page).to have_content(player2.position)
    expect(page).to have_content(player3.name)
    expect(page).to have_content(player3.number)
    expect(page).to have_content(player3.position)
  end
end
