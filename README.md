# README

[![Build Status](https://codeship.com/projects/4c906bd0-3448-0136-6a61-7a9459f2f135/status?branch=master)
[![Code Climate](https://codeclimate.com/github/MattMacKinnon50/FantasyGM/badges/gpa.svg)](https://codeclimate.com/github/MattMacKinnon50/FantasyGM)
[![Coverage Status](https://coveralls.io/repos/github/MattMacKinnon50/FantasyGM/badge.svg?branch=master)](https://coveralls.io/github/MattMacKinnon50/FantasyGM?branch=master)

## FantasyGM

This is a test app to serve as a skills exercise and is not for production.  It does not claim ownership of or affiliation with any property, intellectual or otherwise, or the NFL, NFLPA or any other entities.

This app is looking to provide a unique fantasy football experience, where a user would manage a full NFL roster over multiple seasons.  The app currently only hosts 1 league, and offers roster management functionality.

#### Screen Shot of Sample Team Page:
![Vikings Home Page](/app/assets/images/ScreenShot.png)

#### Production Environment
FantasyGM's production environment can be viewed on [Heroku](https://fantasy-gm.herokuapp.com).


###### Logging In
New users are supported and you can select any team to manage.  Signups have not been restricted as they may be in a running league to allow the functionality to be previewed.

If you would prefer not to register a new account, you can still check out any available team by using "[team name]gm@email.com". For example: giantsgm@email.com, patriotsgm@email.com, and so on.  The password for each of these example users is "password". [I know, not the strongest of security.] Feel free to log in and poke around.

#### Development

The app is built on Rails using Ruby v 2.3.3.  Once the code has been pulled down locally, run `bundle install` and `npm install` to set up the required libraries.  From there, set up your rails database and the db seed file will take care of establishing the team and player objects, as well as placeholder users for all 32 teams.

Once your database is established, in one terminal tab, run `rails -s` and in a seperate tab run `npm start` to initialize your local server.  Open your browser and head to `localhost:8000` to view the site in development.

#### TODO List

- [x] Add team edit functionality.
- [x] Implement basic player search.
- [ ] Implement advanced player search.
- [ ] Add player salary information.
- [ ] Add team salary cap restrictions.
- [ ] Add free agent contract calculator.
- [ ] Add free agency bid process.
- [ ] Add draft board and pick elements.
- [ ] Implement scoring.

#### Contribution Guidelines and Licenses

This is currently a demo and is not accepting contributions at this time.
