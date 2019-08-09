
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;
import java.io.OutputStream; 

    public class postjava {
      

      public static void main(String[] args){

    try {
            String jsona ="{\"temperature\" : \"22.0\",\"humidity\" : \"30.0\",\"lux\" : \"921.21\"}";
            
             
             int i = jsona.indexOf("{");
          jsona = jsona.substring(i);
        //JSONObject json = new JSONObject(jsona.trim());
            URL url = new URL("https://burlingtonhub-orasenatdpltintegration01.integration.ocp.oraclecloud.com/ic/api/integration/v1/flows/rest/PUSHADW/1.0/producer");//your url i.e fetch data from .
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            String basicAuth = "Basic Y2xvdWQuYWRtaW46I0FCQ0RlZmdoMTIzNCM=";
            conn.setRequestProperty ("Authorization", basicAuth);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Accept", "application/json");
            conn.setRequestProperty("Content-Type", "application/json"); 
            conn.setDoOutput(true); 
            OutputStream out = conn.getOutputStream();
            out.write(jsona.toString().getBytes()); 
      //       try(OutputStream os = conn.getOutputStream()) {
      //   byte[] input = jsona.getBytes("utf-8");
      //  os.write(input, 0, input.length);           
      // }

      // catch (Exception e) {
      //       System.out.println("Exception in NetClientGet:- " + e);
      //   }
      System.out.println(conn.getResponseCode());
            if (conn.getResponseCode() != 202) {
                throw new RuntimeException("Failed : HTTP Error code : "
                        + conn.getResponseCode());
            }
            InputStreamReader in = new InputStreamReader(conn.getInputStream());
            BufferedReader br = new BufferedReader(in);
             StringBuilder sb = new StringBuilder();
           // System.out.println("buffer reader "+br);
            String output;
            while ((output = br.readLine()) != null) {
                System.out.println(output);
                sb.append(output);
                System.out.println();
            }
            conn.disconnect();
            //JSONObject json = new JSONObject(sb.toString());
           // System.out.println(json);
           // System.out.println(json.getString("temperature"));

        } catch (Exception e) {
            System.out.println("Exception in NetClientGet:- " + e);
        }


      }
    }