require 'rails_helper'

feature 'user views a team index page' do
  let!(:team) { FactoryBot.create(:team) }
  let!(:team2) { FactoryBot.create(:team) }
  let!(:player1) {FactoryBot.create(:player, team: team)}
  let!(:player2) {FactoryBot.create(:player, position: "QB", team: team)}
  let!(:player3) {FactoryBot.create(:player, position: "RB", team: team)}
  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user, team_id: team2.id )}


  scenario 'not signed in user sees team show ' do
    visit "/teams/#{team.id}"

    expect(page).to have_xpath("//img[@src= \"#{team.wikipedia_wordmark_url}\"]")

  end
end
