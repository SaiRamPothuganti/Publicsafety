const fdk=require('@fnproject/fdk');
const request=require('request');

// UpdateTicket
//
// Updates a Netsuite ticket about a potential fire with new information.
// This code is basically the same as OpenTicket, except for the URI of the endpoint being hit.

function RESTcaller (input) {
  var options = {
    method: 'POST',
    uri: 'https://burlingtonhub-orasenatdpltintegration01.integration.ocp.oraclecloud.com/ic/api/integration/v1/flows/rest/UPDATE_PUBLIC_SAFETY/1.0/ticket',
    headers:
    {
      'cache-control': 'no-cache',
      'Authorization': 'Basic Y2xvdWQuYWRtaW46I0FCQ0RlZmdoMTIzNCM=',
      'Content-Type': 'application/json'
    },
    body:
    {
      timestamp: input.timestamp,     // '13-06-19 12:12:12'
      temperature: input.temperature, // '489.2'
      location: input.location,       // 'Burlington, MA'
      id: input.id,                    // an integer
      status: input.status            // '2' means In Progress
    },
    json: true
  };

  return new Promise( function (resolve, reject) {
    request(options, function (error, response, body) {
      if (error) {
        console.log("error in request: " + err);
        return reject(error);
      }
      try {
        resolve(body);
      } catch(e) {
        console.log("error in catch: " + e);
        reject(e);
      }
    });
  });
}


// When I call RESTcaller(223) by itself, it runs appropriately.
// When I wrap it in fdk.handle (as below), the request happens, but the function never returns.

fdk.handle(function (inputData, ctx) {
  return RESTcaller(inputData);
});
