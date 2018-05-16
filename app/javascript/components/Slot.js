import React from 'react'

const Slot = props => {

  let eligiblePlayerList =[]

  if (props.eligiblePlayers != null) {
    props.eligiblePlayers.forEach ((player) => {
      let key = player.id
      return (
        eligiblePlayerList.push(<option key={key} className="player-dropdown" value={player.id}>{player.number} {player.name} - {player.position} {player.nfl_team} - Bye Week: {player.bye_week}</option>)
      )
    })
}
  let moveToPs
  if (props.psEligible) {
    moveToPs = <label><input name="move-to-ps" className="move-to-ps" type="checkbox" onClick={() =>{props.toggleDemote(props.playerId)}} value={props.playerId}/>  Move to Practice Squad</label>
  }

  eligiblePlayerList.unshift(<option value={null}></option>)

  if (props.role == "starter") {
    if (props.edit) {
      return (
        <li className= {props.className}>
          <form>
            <label className="roster-label">{props.positionName}:<br/>
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
          <span className="slot-data">
            <p className="slot-label">{props.positionName}</p>
            <p className="slot-player"><a href={`/players/${props.playerId}`}>{props.playerName}</a> - #{props.number} {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
          </span>
        </li>
      )
    } else {
        return (
        <li className= {props.className}>
          <span className="slot-data">
            <p className="slot-label">{props.positionName}</p>
            <p className="slot-player">Empty Roster Spot </p>
          </span>
        </li>
        )
      }
    }
  } else if (props.role == "b")  {
    if (props.edit) {
      return (
        <li className= {props.className}>
          <form>
            <p><a href={`/players/${props.playerId}`}>{props.playerName}</a> - #{props.number} {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
            <div className="bench-buttons">
              <label><input className= "drop-player" name="drop-player" type="checkbox" onChange={() => {props.toggleDrop(props.playerId)}} value={props.playerId}/>  Release Player to Free Agency</label>
              {moveToPs}
            </div>
          </form>
        </li>
      )
    } else {
      return (
      <li className= {props.className}>
        <p><a href={`/players/${props.playerId}`}>{props.playerName}</a> - #{props.number} {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
      </li>
    )}
  } else   {
      if (props.edit) {
        return (
          <li className= {props.className}>
            <p><a href={`/players/${props.playerId}`}>{props.playerName}</a> - #{props.number} {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
            <div className="bench-buttons">
              <label><input className= "promote-player" name="promote-player" type="checkbox" onClick={() => {props.togglePS(props.playerId)}} value={props.playerId}/> Promote Player to Bench</label>
            </div>
          </li>
        )
      } else {
        return (
        <li className= {props.className}>
          <p><a href={`/players/${props.playerId}`}>{props.playerName}</a> - #{props.number} {props.position} {props.nflTeam} - Bye Week: {props.byeWeek}</p>
        </li>
        )
      }
    }
  }


export default Slot
