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
      te2: null,
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
      teamId: null,
      players: []
    }
    this.triggerFetch = this.triggerFetch.bind(this)
  }

  componentDidMount() {
    this.setState({teamId: parseInt(this.props.params.id)})
    this.triggerFetch()
  }

  triggerFetch() {
  fetch('/api/v1/players')
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
      const newResponse = response["players"]
      const teamPlayers = newResponse.map((player) => {
        if (player.team_id === this.state.teamId) {
          return player
        }
      })

      this.setState({
        players: teamPlayers
      })
    })
    .catch ( error => console.error(`Error in fetch: ${error.message}`) );
  }

  render() {
    return (
      <p> Hello from React.</p>
    )
  }
}

export default Roster;
