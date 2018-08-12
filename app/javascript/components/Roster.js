import React, { Component } from 'react';
import Slot from './Slot'

class Roster extends Component {
  constructor(props) {
    super(props);
    this.state = {
      lineup: {qb: {name: "QB", positions: ["QB"], player: null}, rb1: {name: "RB", positions: ["RB", "FB"], player: null}, rb2: {name: "RB", positions: ["RB", "FB"], player: null}, wr1: {name: "WR", positions: ["WR"], player: null}, wr2: {name: "WR", positions: ["WR"], player: null}, wr3: {name: "WR", positions: ["WR"], player: null}, wr4: {name: "WR", positions: ["WR"], player: null}, te: {name: "TE", positions: ["TE"], player: null}, teWrRb: {name: "TE/WR/RB", positions: ["TE", "WR", "RB", "FB"], player: null}, ot1: {name: "OT", positions: ["OT", "OL"], player: null}, ot2: {name: "OT", positions: ["OT", "OL"], player: null}, g1: {name: "G", positions: ["G", "OL"], player: null}, g2: {name: "G", positions: ["G", "OL"], player: null}, c: {name: "C", positions: ["C", "OL", "LS"], player: null}, dt: {name: "DT", positions: ["DT", "NT", "DL"], player: null}, de1: {name: "DE", positions: ["DE", "DL"], player: null}, de2: {name: "DE", positions: ["DE", "DL"], player: null}, ilb: {name: "ILB", positions: ["ILB", "LB"], player: null}, olb1: {name: "OLB", positions: ["OLB", "LB"], player: null}, olb2: {name: "OLB", positions: ["OLB", "LB"], player: null}, dtLb: {name: "DT/LB", positions: ["DT", "NT", "LB", "ILB", "OLB", "DL"], player: null}, cb1: {name: "CB", positions: ["CB"], player: null}, cb2: {name: "CB", positions: ["CB", "DB"], player: null},  ss: {name: "SS", positions: ["SS", "S"], player: null}, fs: {name: "FS", positions: ["FS", "S"], player: null}, cbS: {name: "CB/S", positions: ["CB", "S", "FS", "SS", "DB"], player: null}, p: {name: "P", positions: ["P"], player: null}, k: {name: "K", positions: ["K"], player: null}},
      players: [],
      edit: false,
      editButton: "Edit Lineup",
      manager: "false",
      playersToDrop: [],
      playersToDemote: [],
      playersToPromote: []
    }
    this.triggerFetch = this.triggerFetch.bind(this)
    this.setLineup = this.setLineup.bind(this)
    this.generateRosterSlots = this.generateRosterSlots.bind(this)
    this.generateBench = this.generateBench.bind(this)
    this.generatePS = this.generatePS.bind(this)
    this.toggleEdit = this.toggleEdit.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
    this.getCookie = this.getCookie.bind(this)
    this.toggleDrop = this.toggleDrop.bind(this)
    this.toggleDemote = this.toggleDemote.bind(this)
    this.togglePS = this.togglePS.bind(this)
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

  toggleDrop(id) {
    let playersToDrop = this.state.playersToDrop
    if (playersToDrop.includes(id)) {
      let index = playersToDrop.indexOf(id)
      playersToDrop.splice(index, 1)
    } else {
      playersToDrop.push(id)
    }
    this.setState({playersToDrop: playersToDrop})
  }

  togglePS(id) {
    let playersToPromote = this.state.playersToPromote
    if (playersToPromote.includes(id)) {
      let index = playersToPromote.indexOf(id)
      playersToPromote.splice(index, 1)
    } else {
      playersToPromote.push(id)
    }
    this.setState({playersToPromote: playersToPromote})

  }

  toggleDemote(id) {
    let playersToDemote = this.state.playersToDemote
    if (playersToDemote.includes(id)) {
      let index = playersToDemote.indexOf(id)
      playersToDemote.splice(index, 1)
    } else {
      playersToDemote.push(id)
    }
    this.setState({playersToDemote: playersToDemote})

  }

  handleSubmit(event) {
    event.preventDefault()
    let lineup = this.state.lineup
    let playersToDrop = this.state.playersToDrop
    let playersToDemote = this.state.playersToDemote
    let playersToPromote = this.state.playersToPromote
    let playersToUpdate = {}
    let updatedPlayers = 0
    updatedPlayers += playersToDrop.length
    updatedPlayers += playersToDemote.length
    updatedPlayers += playersToPromote.length
    for (var key in lineup) {
      if (!lineup.hasOwnProperty(key)) continue;
      let currentStarter = lineup[key]["player"]
      let currentStarterId
      if (currentStarter) {
        currentStarterId = currentStarter["id"]
      } else {
        currentStarterId = null
      }
      let starters = document.getElementById(key)
      let newStarterId
      if (starters.value != "") {
        newStarterId = parseInt(starters.value)
      } else {
        newStarterId = null
      }
      if (currentStarterId == newStarterId) {continue}
      updatedPlayers += 1
      if (currentStarterId) {playersToUpdate[currentStarterId] = "b"}
      if (newStarterId) {playersToUpdate[newStarterId] = key}
    }
    playersToDrop.forEach((playerId) => {
      playersToUpdate[playerId] = "FA"
    })
    playersToDemote.forEach((playerId) => {
      playersToUpdate[playerId] = "ps"
    })
    playersToPromote.forEach((playerId) => {
      playersToUpdate[playerId] = "b"
    })


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
         this.setState({
           playersToDrop: [],
           playersToDemote: [],
           playersToPromote: []
         })
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
            if (player["position"] == position  && player["role"] != "ps") {
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
              currentCap={player["current_cap"]}
              edit={this.state.edit}
              psEligible={player["ps_eligibility"]}
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
                currentSalary={null}
                edit={this.state.edit}
              />
            )
        }
    }
    return slots
  }

  toggleEdit() {
    if (this.state.edit == false) {
      this.setState({
        edit: true,
        editButton: "Cancel",
        playersToDrop: [],
        playersToDemote: [],
        playersToPromote: []
      })
    } else {
      this.setState({
        edit: false,
        editButton: "Edit Lineup",
        playersToDrop: [],
        playersToDemote: [],
        playersToPromote: []
      })
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
            currentCap={player["current_cap"]}
            role={"b"}
            edit={this.state.edit}
            psEligible={player["ps_eligibility"]}
            toggleDrop={this.toggleDrop}
            toggleDemote={this.toggleDemote}
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
            currentCap={player["current_cap"]}
            role={"ps"}
            edit={this.state.edit}
            psEligible={player["ps_eligibility"]}
            togglePS={this.togglePS}
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
      submitButton = <button className="roster-button" onClick={this.handleSubmit}>Save Lineup</button>
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
