import React from 'react'
import { Router, Route, IndexRoute, browserHistory } from 'react-router';
import Roster from '../components/Roster'
import NewTradeForm from '../components/NewTradeForm'

const App = props => {
  return(
    <Router history={browserHistory}>
      <Route path={`/teams/:id`} component={Roster} />
      <Route path={`/trades/new`} component={NewTradeForm} />
    </Router>
  )
}

export default App
