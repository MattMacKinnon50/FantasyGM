require 'rails_helper'

feature 'user views a team index page' do
  let!(:league) { FactoryBot.create(:league) }
  let!(:team1) { FactoryBot.create(:team) }
  let!(:team2) { FactoryBot.create(:team, remote_logo_url: 'https://upload.wikimedia.org/wikipedia/en/c/c1/Tennessee_Titans_logo.svg')  }
  let!(:user) { FactoryBot.create(:user, team_id: team1.id) }


  scenario 'not signed in user sees team index ' do
    visit "/teams"

    expect(page).to have_content("Teams")
    expect(page).to have_xpath("//img[@src= \"#{team1.logo}\"]")
    expect(page).to have_xpath("//img[@src= \"#{team2.logo}\"]")
  end

  scenario 'signed in user sees team index ' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    visit "/teams"

    expect(page).to have_content("Teams")
    expect(page).to have_xpath("//img[@src= \"#{team1.logo}\"]")
    expect(page).to have_xpath("//img[@src= \"#{team2.logo}\"]")
  end

end
