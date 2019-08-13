const fdk=require('@fnproject/fdk');
const request=require('request');

// OpenTicket
//
// Opens a ticket on NetSuite about drone activity and a potential fire.

function RESTcaller (input) {
  //console.log("input received: " + input);
  var options = {
    method: 'POST',
    uri: 'https://BurlingtonHUB-orasenatdpltintegration01.integration.ocp.oraclecloud.com:443/ic/api/integration/v1/flows/rest/PUBLIC_SAFETY_V2/1.0/metadata/ticket',
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
      status: input.status            // '1'
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
//        console.log("body returned: " + body);
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
