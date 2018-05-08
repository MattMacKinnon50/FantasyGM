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
      teWr: null,
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
      players: []
    }
    this.triggerFetch = this.triggerFetch.bind(this)
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
    })
    .catch ( error => console.error(`Error in fetch: ${error.message}`) );
  }

  render() {
    debugger
    return (
      <p> Hello from React.</p>
    )
  }
}

export default Roster;
