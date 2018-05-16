import React from 'react'

const Asset = props => {

  if (props.toggleTrade) {
    return (
      <li className= "trade-asset">
        <form>
          <div className="bench-buttons">
            <label><input className= "player-asset" name="trade-player" type="checkbox" onChange={() => {props.toggleTrade(props.team, props.playerId)}} value={props.playerId}/> {props.playerFirstName} {props.playerLastName} - #{props.number} {props.position} {props.playerNflTeam}- Bye Week: {props.byeWeek}</label>
          </div>
        </form>
      </li>
    )
  } else {
    return (
      <p>{props.playerFirstName} {props.playerLastName} - {props.position} - {props.playerNflTeam}</p>
    )
  }
}

export default Asset
