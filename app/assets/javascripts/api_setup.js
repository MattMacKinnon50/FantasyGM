let data = {
   "username":"MattMacKinnon50",
   "password":"royals12",
   "firstName":"Matt",
   "lastName":"MacKinnon",
   "emailAddress":"matthew.mackinnon.50@gmail.com",
   "street":"126 Bridge Street",
   "city":"Beverly",
   "state":"MA",
   "country":"US",
   "zip":"01915",
   "birthYear" : 1981,
   "birthMonth" : 07,
   "birthDay" : 02,
   "optIn" : "true",
   "favoriteTeams" : ["NE"],
}

let jsonStringData = JSON.stringify(data);

fetch('https://api.nfl.com/v1/users', {
  method: 'put',
  body: jsonStringData
})
  .then(response => {
    if (response.ok) {
      return response;
    } else {
      let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage);
      throw(error);
    }
  })
  .then(response => response.json())
  .then(body => {
    console.log(body);
  })
  .catch(error => console.error(`Error in fetch: ${error.message}`));
