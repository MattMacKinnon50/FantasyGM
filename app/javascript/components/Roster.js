import React, { Component } from 'react';
import Slot from './Slot'

class Roster extends Component {
  constructor(props) {
    super(props);
    this.state = {
      lineup: {qb: null, rb1: null, rb2: null, wr1: null, wr2: null, wr3: null, wr4: null, te1: null, teWrRb: null, ot1: null, ot2: null, g1: null, g2: null, c: null, dt1: null, dt2: null, de1: null, de2: null, ilb1: null, ilb2: null, olb1: null, olb2: null, cb1: null, cb2: null, cb3: null, ss: null, fs: null, p: null, k: null},
      players: [],
    }
    this.triggerFetch = this.triggerFetch.bind(this)
    this.setLineup = this.setLineup.bind(this)
    this.generateSlots = this.generateSlots.bind(this)
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
      lineup[key] = starter
    }
    this.setState({ lineup: lineup })
  }

  generateSlots() {
    const lineup = this.state.lineup
    const slots = []
    for (var key in lineup) {
      if (!lineup.hasOwnProperty(key)) continue;
      var player = lineup[key]
      if (player != null) {
        slots.push(
            <Slot
              key={key}
              slot={key}
              name={player["name"]}
              position={player["position"]}
              number={player["number"]}
              nflTeam={player["nfl_team"]}
              firstName={player["first_name"]}
              lastName={player["last_name"]}
              byeWeek={player["bye_week"]}
            />
          )
        } else {
          slots.push(
              <Slot
                key={key}
                slot={key}
                name={"Empty"}
                position= {null}
                number={null}
                nflTeam={null}
                firstName={null}
                lastName={null}
                byeWeek={null}
              />
            )
        }
    }
    debugger
    return slots
  }

  render() {
    this.generateSlots()
    debugger
    return (
      <div id="starters">
        { slots }
      </div>
      )
  }
}

export default Roster;
