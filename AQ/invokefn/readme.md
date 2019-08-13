# Invoke Oracle Functions by its Endpoint

This example demonstrates how to invoke a function deployed to Oracle Functions
by its invoke endpoint URL. It's a fork and expansion of https://github.com/shaunsmith/fn-node-invokebyendpoint.git for use with the Public Safety 2.0 demo project.

## Pre-requisites

1. Install/update the Fn CLI

   `curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install |
   sh`

2. Setup your OCI config file as described in the Oracle Functions quick start guide.

3. Create a function to invoke. (See the "Functions" directory in the root of this repository for the Public Safety 2.0 functions and how to set them up.)

## Setup

1. Install the required Node modules:

    `npm install`

2. Copy `config.template` to `config.yaml` and add your OCI details.  (NOTE: If
   you've configured the fn CLI to work with Oracle Functions you can copy
   values from your `~/.oci/config` and fn context file).

    ```yaml
    tenancyId: <ocid>
    compartmentId: <ocid>
    userId: <ocid>
    keyFingerprint:
    privateKeyPath:
    passphrase:
    ```

3. Inspect a function to get its invoke endpoint.  For example, if you have a
   function "hello" in the "quickstart" application, you can inspect the function
   with:

    `fn inspect f quickstart hello`

   This will return JSON similar to the following:

   ```json
   {
     "annotations": {
       "fnproject.io/fn/invokeEndpoint": "https://iagu5qcq6iq.us-phoenix-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.phx.aaaaaaaaac4lertr6bwpulbgqogsv753afil4zytaazomqxlebdfov2isnoq/actions/invoke",
       "oracle.com/oci/compartmentId": "ocid1.compartment.oc1..aaaaaaaaokbzj2jn3hf5kwdwqoxl2dq7u54p3tsmxrjd7s3uu7x23tkegiua"
     },
     "app_id": "ocid1.fnapp.oc1.phx.aaaaaaaaafqfe5nuqtxw4lyjf3wf7vbzwqzmcll3pf3bztcwviagu5qcq6iq",
     "created_at": "2019-03-21T16:33:46.989Z",
     "id": "ocid1.fnfunc.oc1.phx.aaaaaaaaac4lertr6bwpulbgqogsv753afil4zytaazomqxlebdfov2isnoq",
     "idle_timeout": 30,
     "image": "phx.ocir.io/oracle-serverless-devrel/shaunsmith/hello:0.0.9",
     "memory": 128,
     "name": "hello",
     "timeout": 30,
     "updated_at": "2019-03-21T18:16:27.729Z"
   }
   ```

   To get just the invoke endpoint URL, add `--endpoint` to the inspect command:

   `fn inspect f quickstart hello --endpoint`

   Running this command for the example function above, the response would be:

   `https://iagu5qcq6iq.us-phoenix-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.phx.aaaaaaaaac4lertr6bwpulbgqogsv753afil4zytaazomqxlebdfov2isnoq/actions/invoke`

4. You can now invoke the function using `invokefunc.js` with its endpoint.
   The command syntax is:

   `node invokefunc.js <invoke endpoint url>`

   For example using the invoke endpoint for our `hello` function:

   `node invokefunc.js https://iagu5qcq6iq.us-phoenix-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.phx.aaaaaaaaac4lertr6bwpulbgqogsv753afil4zytaazomqxlebdfov2isnoq/actions/invoke`

5. Most of the functions for the Public Safety project require a JSON body payload. You can invoke them and add that payload by running `invokefunc-body.js` like this:

    `node invokefunc-body.js <endpoint url> <JSON filename>`
