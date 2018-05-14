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
      otherTeamId: "",
      otherTeam: null,
      currentTeamAssets: [],
      otherTeamAssets: []
    }
    this.getCookie = this.getCookie.bind(this)
    this.triggerFetch = this.triggerFetch.bind(this)
    this.buildTeam1Available = this.buildTeam1Available.bind(this)
    this.toggleTrade = this.toggleTrade.bind(this)
    this.buildTeam1ToTrade = this.buildTeam1ToTrade.bind(this)
    this.buildTeamDropdown = this.buildTeamDropdown.bind(this)
    this.handleTeamChange = this.handleTeamChange.bind(this)
    this.buildTeam2Available = this.buildTeam2Available.bind(this)
    this.buildTeam2ToTrade = this.buildTeam2ToTrade.bind(this)
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

  buildTeam2Available() {
    let teamId = this.state.otherTeamId
    let allPlayers = this.state.otherPlayers
    let players = []
    allPlayers.forEach((player) => {
      if (player["team_id"] == teamId) {
        players.push(player)
      }
    })
    let playerAssets = players.map((player) => {
      return(
        <Asset
          key={player["id"]}
          team= "2"
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
  buildTeam2ToTrade() {
    let playerIds = this.state.otherTeamAssets
    let players = this.state.otherPlayers
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

  buildTeamDropdown() {
    let teams = this.state.otherTeams
    let options = teams.map((team) => {
      return (
        <option key ={team["id"]} value={team["id"]}> {team["city"]} {team["name"]}</option>
      )
    })
    return options
  }

  handleTeamChange(event) {
    let id = parseInt(event.target.value)
    let otherTeam = null
    let otherTeams = this.state.otherTeams
    otherTeams.forEach((team) => {
      if (team["id"] == id) {
        otherTeam = team
      }
    })
    this.setState({
      otherTeamId: id,
      otherTeam: otherTeam,
      otherTeamAssets: []
    })
  }


  render() {
    let team1Assets = this.buildTeam1Available()
    let team2Assets = this.buildTeam2Available()
    let team1ToTrade = this.buildTeam1ToTrade()
    let team2ToTrade = this.buildTeam2ToTrade()
    let team1Name
    if (this.state.currentTeam) {
      team1Name = `${this.state.currentTeam["city"]} ${this.state.currentTeam["name"]}`
    }
    let team2Name
    if (this.state.otherTeam) {
      team2Name = `${this.state.otherTeam["city"]} ${this.state.otherTeam["name"]}`
    } else {
      team2Name = ""
    }
    let options = this.buildTeamDropdown()
    return (
      <div>
        <h3> {team1Name} and {team2Name} </h3>
        <hr/>
        <div className="row">
          <h5>Players to Trade</h5>
          <div className="columns small-6">
            <ul>
              {team1ToTrade}
            </ul>
          </div>
          <div className="columns small-6">
            <ul>
              {team2ToTrade}
            </ul>
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
            <form>
              <select value={this.state.otherTeamId} onChange={this.handleTeamChange}>
                {options}
              </select>
            </form>
            <ul>
              {team2Assets}
            </ul>
          </div>
        </div>
      </div>
    )


  }
}

export default NewTradeForm;
