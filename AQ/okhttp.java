

OkHttpClient client = new OkHttpClient();

Request request = new Request.Builder()
  .url("https://burlingtonhub-orasenatdpltintegration01.integration.ocp.oraclecloud.com/ic/api/integration/v1/flows/rest/WIO_PRODUCER/1.0/pushtoadw")
  .get()
  .addHeader("Authorization", "Basic Y2xvdWQuYWRtaW46I0FCQ0RlZmdoMTIzNCM=")
  .addHeader("cache-control", "no-cache")
  .addHeader("Postman-Token", "3078649c-637c-4c3d-af23-2ceb8e606bc5")
  .build();

Response response = client.newCall(request).execute();