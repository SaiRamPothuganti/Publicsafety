const fdk=require('@fnproject/fdk');
const request=require('request');
const http = require('http')
const fetch = require('node-fetch')
const FormData = require('form-data')

// OpenTicketCallDrone
//
// Opens a ticket on NetSuite about drone activity and a potential fire.
// Tells the drone to fly to investigate the fire.

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

// invoke the drone to start flying.

async function callDrone(hostname, remark) {
  const form = new FormData()
  form.append('remark', remark)

  var uri = 'http://' + hostname + '/file/upload/'

  //console.log('hostname will be ' + hostname.split('.')[:])
  const options = {
    method: 'POST',
    body: form
  }

  return new Promise( async function (resolve, reject) {
    var json = {}
    await fetch(uri, options)
      .then(function(res) {
        resolve(res.body.json())
      })
      .catch(e => {
        console.log('error in callDrone: ' + e)
        reject(e)
      })
  })

}


fdk.handle(function (inputData, ctx) {
  await callDrone(inputdata.hostname, inputdata.remark)
  return RESTcaller(inputData)

});
