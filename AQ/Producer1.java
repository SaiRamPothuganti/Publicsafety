import java.util.Properties;
import org.apache.kafka.clients.producer.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;

public class Producer1 {
public static void main(String[] args) {
	KafkaProducer<String,String> prod = null;
   int msgCnt = Integer.parseInt(args[0]);
	 Properties props = new Properties();
	 props.put("oracle.service.name", "pdb1.sub02251514100.datamarketplace.oraclevcn.com");
	 props.put("oracle.instance.name", "datamart");
     props.put("oracle.user.name", "aq");
     props.put("oracle.password", "GOstrROng_#24");
	 props.put("bootstrap.servers", "129.146.160.141:1521");
	 props.put("retries", 0);
	 props.put("batch.size", 5000);
	 props.put("linger.ms", 1000);
	 props.put("buffer.memory", 3355443);
	 props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
	 props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");	
	  
	 prod=new KafkaProducer<String, String>(props);
	 try {
		 URL url = new URL("https://burlingtonhub-orasenatdpltintegration01.integration.ocp.oraclecloud.com/ic/api/integration/v1/flows/rest/DRONESENSORSPS/1.0/drone");
	  String basicAuth = "Basic Y2xvdWQuYWRtaW46I0FCQ0RlZmdoMTIzNCM=";
       System.out.println("Producing messages " + msgCnt);
			 for(int j=0;j<msgCnt; j++) {
				 System.out.println("inside looop"+j);
				  HttpURLConnection conn = (HttpURLConnection) url.openConnection();
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
			System.out.println(sb.toString());
			 conn.disconnect();
			  prod.send(new ProducerRecord<String, String>("Test99" , Integer.toString(j)+"000",sb.toString()));
				 //prod.send(new ProducerRecord<String, String>("Test98" ,output));
			       //System.out.println(met.timestamp()+"  "+met.offset()+ " " + (met.offset()>>>16));
			 }
       System.out.println("Messages sent " );
       
	 } catch(Exception ex) {
		 ex.printStackTrace();
	 }
	 finally {
		 prod.close();
	 }

	
}
}

