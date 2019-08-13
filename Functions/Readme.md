# README for Public Safety 2.0 functions

## To set up your Functions environment:

**This section is challenging if you've never done it before. Prepare to spend most of a day making this work the first time you try it.**

* Configure your environment to interact properly with OCIR.
  * Install the OCI CLI as described at <https://docs.cloud.oracle.com/iaas/Content/API/SDKDocs/cliinstall.htm>.
  * Follow the first part of the instructions in <https://blogs.oracle.com/developers/oracle-functions:-serverless-on-oracle-cloud-developers-guide-to-getting-started-quickly>, up to the part where you create your first function.
    * The script you run during this process to set up your OCI tenancy is located in this repository as `oci-fn-config.sh`, but you'll still need to edit it to configure it for your tenancy. (And even then, it may be buggy. This process will take you some time to get right.)
* When you get to the `fn create app` step, call your application `ps20`.

## To install the functions themselves:

* Make sure you're logged into Docker on the command line.

* For each of the functions, `pushd` into the function directory, then run `fn -v deploy --app ps20` to deploy the function, then `popd`.


## To invoke the functions:

* for each function, you'll have to get the OCI endpoint URL. You can do this by running `fn inspect f appname functionname`, for example `fn inspect f ps20 evaluateimage`, and then reading through the output for the invocation URL. To get just the invoke endpoint URL, add `--endpoint` to the inspect command:

`fn inspect f ps20 evaluateimage --endpoint`

**For full details on invoking the functions, see `/AQ/invokefn/readme.md` in this repository.**
