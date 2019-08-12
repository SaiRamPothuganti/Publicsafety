const fdk=require('@fnproject/fdk');
const fs=require('fs');
const fetch=require('node-fetch');
const FormData = require('form-data');

// Evaluate the drone's image and find out whether it looks like a fire.
// curl -X POST --noproxy '*' http://132.145.211.255:9093/oaa-scoring/services/v1/myservices/adapted_1/score  -F  "imageData=@$i" -H "Content-Type: multipart/form-data; boundary=BOUNDARY" -H "Accept: application/json" -w "   \n\n\n\n"


function POSTcaller (inputFileName, context) {
  const form = new FormData();
  form.append('imageData', fs.createReadStream(inputFileName));

  var uri = 'http://132.145.211.255:9093/oaa-scoring/services/v1/myservices/adapted_1/score'
  const options = {
    method: 'POST',
    body: form
  }

  return new Promise( async function (resolve, reject) {
    await fetch(uri, options)
      .then(function(res) {
        myJSON = res.json()
        console.log("JSON is " + myJSON)
        return myJSON
      })
      .then(function(json) {resolve(json) })
      .catch(e => {
        console.log('error in POSTcaller: ' + e)
        reject(e)
      })
  })
}

async function download (uri, filename) {
  await fetch(uri)
    .then(res => {
      const dest = fs.createWriteStream(filename)
      res.body.pipe(dest)
    })
    .then(function(res) {
      console.log('download succeeded')
    })
    .catch(function (err) {
      console.log('download failed of ' + uri + ' to ' + filename)
    })
}



fdk.handle(async function (input, ctx) {
  console.log('received input url ' + input.imageurl)
  var inputFileURL = String(input.imageurl);
  var inputFileName = '/tmp/' + inputFileURL.substring(inputFileURL.lastIndexOf('/')+1);
  console.log('downloading image from ' + inputFileURL + ' to ' + inputFileName);

  // save image to local filesystem

  var retval = ''
  await download(inputFileURL, inputFileName)

  retval = await POSTcaller(inputFileName)
  console.log("retval is " + retval)
  return retval
})
