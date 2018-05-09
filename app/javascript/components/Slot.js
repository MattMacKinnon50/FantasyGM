import React, { Component } from 'react';

class Slot extends Component {
  constructor(props) {
    super(props);
    this.state = {
      showMenu: false,
    }
  }

  render() {
    if (this.props.starter) {
      if (this.props.playerId != null) {
      return (
        <li className= {this.props.className}>
          <p>{this.props.positionName} - {this.props.number} <a href={`/players/${this.props.playerId}`}>{this.props.playerName}</a> - {this.props.position} {this.props.nflTeam} - Bye Week: {this.props.byeWeek}</p>
          <div>
              <button>
                Show menu
              </button>
                {if (this.state.showMenu) {
              <div className="menu">
                <button> Menu item 1 </button>
                <button> Menu item 2 </button>
                <button> Menu item 3 </button>
              </div>
            }
          </div>

        </li>
      )
    } else{
        return (
        <li className= {this.props.className}>
          <p>{this.props.positionName} - Empty Roster Spot </p>
          <div>
            <button>
              Show menu
            </button>
            {if (this.state.showMenu) {
                <div className="menu">
                  <button> Menu item 1 </button>
                  <button> Menu item 2 </button>
                  <button> Menu item 3 </button>
                </div>
              }
            </div>
          </div>
        </li>
        )
      }
    } else {
      return (
        <li className= {this.props.className}>
          <p>{this.props.number} <a href={`/players/${this.props.playerId}`}>{this.props.playerName}</a> - {this.props.position} {this.props.nflTeam} - Bye Week: {this.props.byeWeek}</p>
        </li>
      )
    }
  }
}


export default Slot
