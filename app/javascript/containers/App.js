import React from 'react'
import { Router, Route, IndexRoute, browserHistory } from 'react-router';
import Roster from '../components/Roster'

const App = props => {
  return(
    <Router history={browserHistory}>
      <Route path={`/teams/:id`} component={Roster} />
    </Router>
  )
}

export default App
