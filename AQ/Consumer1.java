import java.time.Duration;
import java.util.Arrays;
import java.util.Properties;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;
import java.io.OutputStream; 

public class Consumer1 {
	public static void main(String[] args) {
         System.out.println("Creating Consumer ");
		 Properties props = new Properties();
	    props.put("oracle.sid", "datamart");
      props.put("oracle.service.name", "pdb1.sub02251514100.datamarketplace.oraclevcn.com");
      props.put("oracle.instance.name", "datamart");
  		props.put("oracle.user.name", "aq");
  		props.put("oracle.password", "GOstrROng_#24");
	    props.put("bootstrap.servers", "129.146.160.141:1521");
		 props.put("group.id", "S1");
	    props.put("enable.auto.commit", "false");
	    props.put("auto.commit.interval.ms", "1000");
	    props.put("key.deserializer", 
	       "org.apache.kafka.common.serialization.StringDeserializer");
	    props.put("value.deserializer", 
	       "org.apache.kafka.common.serialization.StringDeserializer");  props.put("isolation.level", "read_uncommitted");
	     props.put("max.poll.records", 500);
	     KafkaConsumer<String, String> consumer = null;
	     try {
             System.out.println("Creating Consumer ");
	    	 consumer = new KafkaConsumer<String, String>(props);
	 	   	 consumer.subscribe(Arrays.asList("Test99"));
	 	    while(true){
	 	    ConsumerRecords<String, String> records;
               System.out.println("Attempting dequeue");
	 	    	records = consumer.poll(Duration.ofMillis(1000));
		 	    for (ConsumerRecord<String, String> record : records)
		 	    {
		 	  
		 	    // print the offset,key and value for the consumer records.
		 	  	  System.out.println("topic = , key = , value = \n"+ 
		 	  	            record.topic()+ " " + record.key()+ " " + record.value());

				JSONObject json = new JSONObject(record.value());
				System.out.println("temp aaa "+json.getString("temperature"));  
				URL url = new URL("https://burlingtonhub-orasenatdpltintegration01.integration.ocp.oraclecloud.com/ic/api/integration/v1/flows/rest/PUSHDRONEDATA/1.0/producer");//your url i.e fetch data from .
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            String basicAuth = "Basic Y2xvdWQuYWRtaW46I0FCQ0RlZmdoMTIzNCM=";
            conn.setRequestProperty ("Authorization", basicAuth);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Accept", "application/json");
            conn.setRequestProperty("Content-Type", "application/json"); 
            conn.setDoOutput(true); 
            OutputStream out = conn.getOutputStream();
            out.write(json.toString().getBytes()); 
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
				


		 	    }
			 
		 	   consumer.commitSync();
			 }
	     }catch(Exception ex) {
         System.out.println("Exception " + ex);
	    	 ex.printStackTrace();
	    	 consumer.close();
	     }
	}    
     
}

