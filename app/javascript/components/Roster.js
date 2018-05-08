import React, { Component } from 'react';

class Roster extends Component {
  constructor(props) {
    super(props);
    this.state = {
      qb: null,
      rb1: null,
      rb2: null,
      wr1: null,
      wr2: null,
      wr3: null,
      wr4: null,
      te1: null,
      teWrRb: null,
      ot1: null,
      ot2: null,
      g1: null,
      g2: null,
      c: null,
      dt1: null,
      dt2: null,
      de1: null,
      de2: null,
      ilb1: null,
      ilb2: null,
      olb1: null,
      olb2: null,
      cb1: null,
      cb2: null,
      cb3: null,
      ss: null,
      fs: null,
      p: null,
      k: null,
      players: []
    }
    this.triggerFetch = this.triggerFetch.bind(this)
    this.setLineup = this.setLineup.bind(this)
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
    const positions = ["qb", "rb1", "rb2", "wr1", "wr2", "wr3", "wr4", "te", "teWrRb", "ot1", "ot2", "g1", "g2", "c", "dt1", "dt2", "de", "de", "ilb1", "ilb2", "olb1", "olb2", "cb1", "cb2", "cb3", "fs", "ss", "p", "k"]
    const players = this.state.players
    var lineup = {}
    positions.forEach(function(position) {
      var starter = null
      players.forEach(function(player) {
        if (player["starting"] == position) {
          starter = player
          }
        })
      lineup[position] = starter
    })
      this.setState(lineup)
  }
  render() {

    return (
      <h3>Starting Roster:</h3>

    )
  }
}

export default Roster;
