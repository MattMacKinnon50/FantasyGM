import React, { Component } from 'react';
import Slot from './Slot'

class Roster extends Component {
  constructor(props) {
    super(props);
    this.state = {
      lineup: {qb: {name: "QB", positions: ["QB"], player: null}, rb1: {name: "RB", positions: ["RB"], player: null}, rb2: {name: "RB", positions: ["RB"], player: null}, wr1: {name: "WR", positions: ["WR"], player: null}, wr2: {name: "WR", positions: ["WR"], player: null}, wr3: {name: "WR", positions: ["WR"], player: null}, wr4: {name: "WR", positions: ["WR"], player: null}, te: {name: "TE", positions: ["TE"], player: null}, teWrRb: {name: "TE/WR/RB", positions: ["TE", "WR", "RB"], player: null}, ot1: {name: "OT", positions: ["OT"], player: null}, ot2: {name: "OT", positions: ["OT"], player: null}, g1: {name: "G", positions: ["G"], player: null}, g2: {name: "G", positions: ["G"], player: null}, c: {name: "C", positions: ["C"], player: null}, dt1: {name: "DT", positions: ["DT"], player: null}, dt2: {name: "DT", positions: ["DT"], player: null}, de1: {name: "DE", positions: ["DE"], player: null}, de2: {name: "DE", positions: ["DE"], player: null}, ilb1: {name: "ILB", positions: ["ILB", "LB"], player: null}, ilb2: {name: "ILB", positions: ["ILB", "LB"], player: null}, olb1: {name: "OLB", positions: ["OLB, LB"], player: null}, olb2: {name: "OLB", positions: ["OLB, LB"], player: null}, cb1: {name: "CB", positions: ["CB"], player: null}, cb2: {name: "CB", positions: ["CB"], player: null}, cbS: {name: "CB/S", positions: ["CB", "S"], player: null}, ss: {name: "SS", positions: ["SS", "S"], player: null}, fs: {name: "FS", positions: ["FS", "S"], player: null}, p: {name: "P", positions: ["P"], player: null}, k: {name: "K", positions: ["K"], player: null}},
      players: [],
    }
    this.triggerFetch = this.triggerFetch.bind(this)
    this.setLineup = this.setLineup.bind(this)
    this.generateRosterSlots = this.generateRosterSlots.bind(this)
    this.generateBench = this.generateBench.bind(this)
  }


  componentDidMount() {
    this.triggerFetch()
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
        if (player["starting"] == key) {
          starter = player
          }
        })
      lineup[key]["player"] = starter
    }
    this.setState({ lineup: lineup })
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
              className={"starting-player"}
              slot={key}
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
              starter={true}
            />
          )
        } else {
          slots.push(
              <Slot
                key={key}
                className={"empty-slot"}
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
                starter={true}
              />
            )
        }
    }
    return slots
  }

  generateBench() {
    const allPlayers = this.state.players
    const slots = []
    let key = 0
    allPlayers.forEach((player) => {
      if (player["starting"] == null) {
        key += 1
        slots.push(
          <Slot
            key={key}
            className={"bench-player"}
            playerName={player["name"]}
            playerId={player["id"]}
            position={player["position"]}
            number={player["number"]}
            nflTeam={player["nfl_team"]}
            firstName={player["first_name"]}
            lastName={player["last_name"]}
            byeWeek={player["bye_week"]}
            starter={false}
          />
        )
      }
    })
    return slots
}

  render() {
    let starters = this.generateRosterSlots()
    let bench = this.generateBench()
    return (
      <div>
        <h3>Starting Roster:</h3>
        <ul id="starters">
          { starters }
        </ul>
        <h3>Practice Squad:</h3>
        <ul id="bench">
          { bench }
        </ul>
      </div>
      )
  }
}

export default Roster;
