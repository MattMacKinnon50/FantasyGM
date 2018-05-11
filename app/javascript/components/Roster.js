import React, { Component } from 'react';
import Slot from './Slot'

class Roster extends Component {
  constructor(props) {
    super(props);
    this.state = {
      lineup: {qb: {name: "QB", positions: ["QB"], player: null}, rb1: {name: "RB", positions: ["RB"], player: null}, rb2: {name: "RB", positions: ["RB"], player: null}, wr1: {name: "WR", positions: ["WR"], player: null}, wr2: {name: "WR", positions: ["WR"], player: null}, wr3: {name: "WR", positions: ["WR"], player: null}, wr4: {name: "WR", positions: ["WR"], player: null}, te: {name: "TE", positions: ["TE"], player: null}, teWrRb: {name: "TE/WR/RB", positions: ["TE", "WR", "RB"], player: null}, ot1: {name: "OT", positions: ["OT"], player: null}, ot2: {name: "OT", positions: ["OT"], player: null}, g1: {name: "G", positions: ["G"], player: null}, g2: {name: "G", positions: ["G"], player: null}, c: {name: "C", positions: ["C"], player: null}, dt: {name: "DT", positions: ["DT"], player: null}, de1: {name: "DE", positions: ["DE"], player: null}, de2: {name: "DE", positions: ["DE"], player: null}, ilb: {name: "ILB", positions: ["ILB", "LB"], player: null}, olb1: {name: "OLB", positions: ["OLB", "LB"], player: null}, olb2: {name: "OLB", positions: ["OLB", "LB"], player: null}, dtLb: {name: "DT/LB", positions: ["DT", "LB", "ILB", "OLB"], player: null}, cb1: {name: "CB", positions: ["CB"], player: null}, cb2: {name: "CB", positions: ["CB"], player: null},  ss: {name: "SS", positions: ["SS", "S"], player: null}, fs: {name: "FS", positions: ["FS", "S"], player: null}, cbS: {name: "CB/S", positions: ["CB", "S", "FS", "SS"], player: null}, p: {name: "P", positions: ["P"], player: null}, k: {name: "K", positions: ["K"], player: null}},
      players: [],
      edit: false,
      editButton: "Edit Lineup",
      manager: "false"
    }
    this.triggerFetch = this.triggerFetch.bind(this)
    this.setLineup = this.setLineup.bind(this)
    this.generateRosterSlots = this.generateRosterSlots.bind(this)
    this.generateBench = this.generateBench.bind(this)
    this.generatePS = this.generatePS.bind(this)
    this.toggleEdit = this.toggleEdit.bind(this)
    this.handleStartersSubmit = this.handleStartersSubmit.bind(this)
    this.getCookie = this.getCookie.bind(this)
  }


  componentDidMount() {
    this.setState({ manager: this.getCookie("manager")})
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
    return "";
  }

  triggerFetch() {
    var teamId = parseInt(this.props.params.id)
  fetch(`/api/v1/players.json?id=${teamId}`, {
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
      this.setState({
        players: response["players"]
      })
      this.setLineup()
    })
    .catch ( error => console.error(`Error in fetch: ${error.message}`) );
  }
  setLineup() {
    const players = this.state.players
    let lineup = this.state.lineup
    for (var key in lineup) {
      if (!lineup.hasOwnProperty(key)) continue;
      let starter = null
      players.forEach(function(player) {
        if (player["role"] == key) {
          starter = player
          }
        })
      lineup[key]["player"] = starter
    }
    this.setState({ lineup: lineup, edit: false, editButton: "Edit Lineup" })
  }

  handleStartersSubmit(event) {
    event.preventDefault()
    let lineup = this.state.lineup
    let playersToUpdate = {}
    let updatedPlayers = 0
    for (var key in lineup) {
      if (!lineup.hasOwnProperty(key)) continue;
      let currentStarter = lineup[key]["player"]
      let currentStarterId
      if (currentStarter) {
        currentStarterId = currentStarter["id"]
      } else {
        currentStarterId = null
      }
      let form = document.getElementById(key)
      let newStarterId
      if (form.value != "") {
        newStarterId = parseInt(form.value)
      } else {
        newStarterId = null
      }
      if (currentStarterId == newStarterId) {continue}
      updatedPlayers += 1
      if (currentStarterId) {playersToUpdate[currentStarterId] = "b"}
      if (newStarterId) {playersToUpdate[newStarterId] = key}
    }
    let formPayload = {players: playersToUpdate}
    if (updatedPlayers > 0) {
      fetch('/api/v1/players/1', {
        credentials: 'same-origin',
        method: 'PATCH',
        body: JSON.stringify(formPayload),
        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
      })
      .then(response => {
       if (response.ok) {
         this.triggerFetch()
       } else {
         let errorMessage = `${response.status} (${response.statusText})`,
             error = new Error(errorMessage);
         throw(error);
       }
     })
  }
 }

  generateRosterSlots() {
    const lineup = this.state.lineup
    const allPlayers = this.state.players
    const slots = []
    for (var key in lineup) {
      if (!lineup.hasOwnProperty(key)) continue;
      let player = lineup[key]["player"]
      let eligiblePositions = lineup[key]["positions"]
      let  eligiblePlayers = []

      allPlayers.forEach((player) => {
          eligiblePositions.forEach((position) => {
            if (player["position"] == position) {
            eligiblePlayers.push(player)
            }
          })
        })

      if (player != null) {
        slots.push(
            <Slot
              key={key}
              className={"roster-slot starting-player"}
              slot={key}
              player={player}
              playerName={player["name"]}
              playerId={player["id"]}
              positionName={lineup[key]["name"]}
              eligiblePlayers={eligiblePlayers}
              position={player["position"]}
              number={player["number"]}
              nflTeam={player["nfl_team"]}
              firstName={player["first_name"]}
              lastName={player["last_name"]}
              byeWeek={player["bye_week"]}
              role={"starter"}
              edit={this.state.edit}
              psEligible="true"
            />
          )
        } else {
          slots.push(
              <Slot
                key={key}
                className={"roster-slot empty-slot"}
                slot={key}
                playerName={null}
                playerId={null}
                positionName={lineup[key]["name"]}
                eligiblePlayers={eligiblePlayers}
                position= {null}
                number={null}
                nflTeam={null}
                firstName={null}
                lastName={null}
                byeWeek={null}
                role={"starter"}
                edit={this.state.edit}
                psEligible="true"
              />
            )
        }
    }
    return slots
  }

  toggleEdit() {
    if (this.state.edit == false) {
      this.setState({edit: true, editButton: "Cancel"})
    } else {
      this.setState({edit: false, editButton: "Edit Lineup"})
    }
  }

  generateBench() {
    const allPlayers = this.state.players
    const slots = []
    let key = 0
    allPlayers.forEach((player) => {
      if (player["role"] == "b") {
        key += 1
        slots.push(
          <Slot
            key={key}
            className={"roster-slot bench-player"}
            playerName={player["name"]}
            playerId={player["id"]}
            position={player["position"]}
            number={player["number"]}
            nflTeam={player["nfl_team"]}
            firstName={player["first_name"]}
            lastName={player["last_name"]}
            byeWeek={player["bye_week"]}
            role={"b"}
            edit={this.state.edit}
            psEligible="true"
          />
        )
      }
    })
    return slots
}
  generatePS() {
    const allPlayers = this.state.players
    const slots = []
    let key = 10000
    allPlayers.forEach((player) => {
      if (player["role"] == "ps") {
        key += 1
        slots.push(
          <Slot
            key={key}
            className={"roster-slot ps-player"}
            playerName={player["name"]}
            playerId={player["id"]}
            position={player["position"]}
            number={player["number"]}
            nflTeam={player["nfl_team"]}
            firstName={player["first_name"]}
            lastName={player["last_name"]}
            byeWeek={player["bye_week"]}
            role={"ps"}
            edit={this.state.edit}
            psEligible="true"
          />
        )
      }
    })
    return slots
}

  render() {
    let starters = this.generateRosterSlots()
    let bench = this.generateBench()
    let practiceSquad = this.generatePS()
    let submitButton
    let editButton
    if (this.state.edit) {
      submitButton = <button className="roster-button" onClick={this.handleStartersSubmit}>Save Lineup</button>
    }
    if (this.state.manager == "true") {
      editButton = <button className="roster-button" onClick={this.toggleEdit}>{this.state.editButton}</button>
    }

    return (
      <div>
        {editButton}
        {submitButton}
        <h3 className="roster-title">Starting Roster:</h3>
        <ul id="starters">
          { starters }
        </ul>
        <h3 className="roster-title">Bench:</h3>
        <ul id="bench">
          { bench }
        </ul>
        <h3 className="roster-title">Practice Squad:</h3>
        <ul id="ps">
          { practiceSquad }
        </ul>
      </div>
      )
  }
}

export default Roster;
