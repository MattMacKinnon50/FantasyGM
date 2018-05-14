import React, { Component } from 'react';
import Asset from './Asset'
class NewTradeForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      currentTeamId: null,
      currentTeam: null,
      currentPlayers: [],
      otherTeams: [],
      otherPlayers: [],
      otherTeamId: null,
      currentTeamAssets: [],
      otherTeamAssets: []
    }
    this.getCookie = this.getCookie.bind(this)
    this.triggerFetch = this.triggerFetch.bind(this)
    this.buildTeam1Available = this.buildTeam1Available.bind(this)
    this.toggleTrade = this.toggleTrade.bind(this)
    this.buildTeam1ToTrade = this.buildTeam1ToTrade.bind(this)
  }

  componentDidMount() {
    this.setState({ currentTeamId: parseInt(this.getCookie("team_id"))})
    this.triggerFetch()
  }

  getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
  }

  triggerFetch() {
    const currentTeamId = parseInt(this.getCookie("team_id"))
  fetch(`/api/v1/trades.json`, {
      credentials: 'same-origin',
      headers: { 'Accept': 'application/json', 'Content-Type': 'application/json', }
    })
    .then ( response => {
      if ( response.ok ) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText})`;
          error = new Error(errorMessage);
        throw(error);
      }
    })
    .then ( response => response.json() )
    .then ( response => {
      let players = response["players"]
      let currentPlayers = []
      let otherPlayers = []
      players.forEach((player) => {
        if (player["team_id"] == currentTeamId) {
          currentPlayers.push(player)
        } else {
          otherPlayers.push(player)
        }
      })
      let teams = response["teams"]
      let currentTeam
      let otherTeams = []
      teams.forEach((team) => {
        if (team["id"] == currentTeamId) {
          currentTeam = team
        } else {
          otherTeams.push(team)
        }
      })
      this.setState({
        currentPlayers: currentPlayers,
        otherPlayers: otherPlayers,
        currentTeam: currentTeam,
        otherTeams: otherTeams
      })
    })
    .catch ( error => console.error(`Error in fetch: ${error.message}`) );
  }

  toggleTrade(team, id) {
    let playersToTrade
    let key
    if (team == "1") {
      playersToTrade = this.state.currentTeamAssets
      key = "currentTeamAssets"
    } else {
      playersToTrade = this.state.otherTeamAssets
      key = "otherTeamAssets"
    }
    if (playersToTrade.includes(id)) {
      let index = playersToTrade.indexOf(id)
      playersToTrade.splice(index, 1)
    } else {
      playersToTrade.push(id)
    }
    const stateObject = { key: playersToTrade}

    this.setState( stateObject )
  }

  buildTeam1Available() {
    let players = this.state.currentPlayers
    let playerAssets = players.map((player) => {
      return(
        <Asset
          key={player["id"]}
          team= "1"
          player={player}
          playerFirstName={player["first_name"]}
          playerLastName={player["last_name"]}
          playerId={player["id"]}
          position={player["position"]}
          number={player["number"]}
          playerNflTeam={player["nfl_team"]}
          byeWeek={player["bye_week"]}
          toggleTrade={this.toggleTrade}
        />
      )
    })
    return playerAssets
  }
  buildTeam1ToTrade() {
    let playerIds = this.state.currentTeamAssets
    let players = this.state.currentPlayers
    let playerAssets = []
    players.forEach((player) => {
      if (playerIds.includes(player["id"])) {
        let playerAsset =
          <Asset
            key={player["id"]}
            team= "1"
            player={player}
            playerFirstName={player["first_name"]}
            playerLastName={player["last_name"]}
            playerId={player["id"]}
            position={player["position"]}
            number={player["number"]}
            playerNflTeam={player["nfl_team"]}
            byeWeek={player["bye_week"]}
        />
        playerAssets.push(playerAsset)
        }
      })
    if (playerAssets.length > 0) {
      return playerAssets
    } else {
      return (<li><p className="no-players">Add players to trade</p></li>)
    }
  }

  render() {
    let team1Assets = this.buildTeam1Available()
    let team1ToTrade = this.buildTeam1ToTrade()
    let team1Name
    if (this.state.currentTeam) {
      team1Name = `${this.state.currentTeam["city"]} ${this.state.currentTeam["name"]}`
    }
    return (
      <div>
        <h3> {team1Name} and Team 2 Name </h3>
        <hr/>
        <div className="row">
          <div className="columns small-6">
            <h5>Players to Trade</h5>
            <ul>
              {team1ToTrade}
            </ul>
          </div>
          <div className="columns small-6">
          </div>
        </div>
        <hr/>
        <div className="row">
          <div className="columns small-6">
            <h5>Available Players</h5>
            <ul>
              {team1Assets}
            </ul>
          </div>
          <div className="columns small-6">
          </div>
        </div>
      </div>
    )


  }
}

export default NewTradeForm;
