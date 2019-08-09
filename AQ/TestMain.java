
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;


    public class TestMain {
      

      public static void main(String[] args){

    try {

            URL url = new URL("https://burlingtonhub-orasenatdpltintegration01.integration.ocp.oraclecloud.com/ic/api/integration/v1/flows/rest/WIO_PRODUCER/1.0/pushtoadw");//your url i.e fetch data from .
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            String basicAuth = "Basic Y2xvdWQuYWRtaW46I0FCQ0RlZmdoMTIzNCM=";
            conn.setRequestProperty ("Authorization", basicAuth);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");
        
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP Error code : "
                        + conn.getResponseCode());
            }
            InputStreamReader in = new InputStreamReader(conn.getInputStream());
            BufferedReader br = new BufferedReader(in);
             StringBuilder sb = new StringBuilder();
            System.out.println("buffer reader "+br);
            String output;
            while ((output = br.readLine()) != null) {
                System.out.println(output);
                sb.append(output);
                System.out.println();
            }
            conn.disconnect();
            JSONObject json = new JSONObject(sb.toString());
            System.out.println(sb.toString());
            System.out.println(json.getString("temperature"));

        } catch (Exception e) {
            System.out.println("Exception in NetClientGet:- " + e);
        }


      }
    }