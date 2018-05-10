import React from 'react'

const Slot = props => {

  let eligiblePlayerList =[]

  if (props.eligiblePlayers != null) {
    props.eligiblePlayers.forEach ((player) => {
      return (
        eligiblePlayerList.push(<option key={player.id} value={player.id}>{player.number} {player.name} - {player.position} {player.nfl_team} - Bye Week: {player.bye_week}</option>)
      )
    })
}

  eligiblePlayerList.unshift(<option value={null}></option>)

  if (props.role == "starter") {
    if (props.edit) {
      return (
        <li className= {props.className}>
          <form>
            <label className="roster-label">{props.positionName}:
              <select defaultValue={props.playerId} id={props.slot} className="roster-select">
                {eligiblePlayerList}
              </select>
            </label>
          </form>
        </li>
      )
    } else {
      if (props.playerId != null) {
      return (
        <li className= {props.className}>
          <p>{props.positionName} - {props.number} <a href={`/players/${props.playerId}`}>{props.playerName}</a> - {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
        </li>
      )
    } else {
        return (
        <li className= {props.className}>
          <p>{props.positionName} - Empty Roster Spot </p>
        </li>
        )
      }
    }
  } else if (props.role == "b")  {
      return (
        <li className= {props.className}>
          <p>{props.number} <a href={`/players/${props.playerId}`}>{props.playerName}</a> - {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
        </li>
      )
  } else   {
      return (
        <li className= {props.className}>
          <p>{props.number} <a href={`/players/${props.playerId}`}>{props.playerName}</a> - {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
        </li>
      )
    }
  }


export default Slot
