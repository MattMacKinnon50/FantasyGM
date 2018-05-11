import React from 'react'

const Slot = props => {

  let eligiblePlayerList =[]

  if (props.eligiblePlayers != null) {
    props.eligiblePlayers.forEach ((player) => {
      let key = player.id
      return (
        eligiblePlayerList.push(<option key={key} value={player.id}>{player.number} {player.name} - {player.position} {player.nfl_team} - Bye Week: {player.bye_week}</option>)
      )
    })
}
  let moveToPs
  if (props.psEligible == "true") {
    moveToPs = <label><input name="move-to-ps" className="move-to-ps" type="checkbox" value={props.playerId}/>Move to Practice Squad</label>
  }

  eligiblePlayerList.unshift(<option value={null}></option>)

  if (props.role == "starter") {
    if (props.edit) {
      return (
        <li className= {props.className}>
          <form>
            <label className="roster-label">{props.positionName}:
              <select defaultValue={props.playerId} id={props.slot} className="player-dropdown" >
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
          <hr/>
        </li>
      )
    } else {
        return (
        <li className= {props.className}>
          <p>{props.positionName} - Empty Roster Spot </p>
          <hr/>
        </li>
        )
      }
    }
  } else if (props.role == "b")  {
    if (props.edit) {
      return (
        <li className= {props.className}>
          <form>
            <p>{props.number} <a href={`/players/${props.playerId}`}>{props.playerName}</a> - {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
            <label><input name="drop-player" type="checkbox" value={props.playerId}/> Release Player to Free Agency</label>
            {moveToPs}
          </form>
        </li>
      )
    } else {
      return (
      <li className= {props.className}>
        <p>{props.number} <a href={`/players/${props.playerId}`}>{props.playerName}</a> - {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
      </li>
    )}
  } else   {
      return (
        <li className= {props.className}>
          <p>{props.number} <a href={`/players/${props.playerId}`}>{props.playerName}</a> - {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
        </li>
      )
    }
  }


export default Slot
