const fdk=require('@fnproject/fdk')
const http = require('http')
const fetch = require('node-fetch')
const FormData = require('form-data')

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

fdk.handle(function(input){
  var results = {}
  var message = 'Drone triggered to ' + input.hostname + " with remark " + input.remark
  callDrone(input.hostname, input.remark)
  .then(json => {
     results = "KickoffDrone: Handler triggered call to proxy " + hostname + " with remark " + remark
     return json
  })
  .catch(e => {
     results = "KickoffDrone: proxy not triggered properly"
  })
  console.log(results)

})
