import React from 'react'

const Slot = props => {
  if (props.starter) {
    if (props.playerId != null) {
    return (
      <li className= {props.className}>
        <p>{props.positionName} - {props.number} <a href={`/players/${props.playerId}`}>{props.playerName}</a> - {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
      </li>
    )
  } else{
      return (
      <li className= {props.className}>
        <p>{props.positionName} - Empty Roster Spot </p>
      </li>
      )
    }
  } else {
    return (
      <li className= {props.className}>
        <p>{props.number} <a href={`/players/${props.playerId}`}>{props.playerName}</a> - {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
      </li>
    )
  }
}

export default Slot
