import java.time.Duration;
import java.util.Arrays;
import java.util.Properties;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;

public class Consumer1 {
	public static void main(String[] args) {
         System.out.println("Creating Consumer ");
		
	    Properties props = new Properties();
	    props.put("oracle.sid", "bug9");
      props.put("oracle.service.name", "bug9.regress.rdbms.dev.us.oracle.com");
      props.put("oracle.instance.name", "bug9");
  		props.put("oracle.user.name", "aq");
  		props.put("oracle.password", "aq");
	    props.put("bootstrap.servers", "den02tgo:1521");

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
	 	    
	 	    consumer.subscribe(Arrays.asList("TOPIC2"));
	 	    
	 	    ConsumerRecords<String, String> records;
         System.out.println("Attempting dequeue");
	 	    	records = consumer.poll(Duration.ofMillis(1000));
		 	    for (ConsumerRecord<String, String> record : records)
		 	    {
		 	  
		 	    // print the offset,key and value for the consumer records.
		 	  	  System.out.println("topic = , key = , value = \n"+ 
		 	  	            record.topic()+ " " + record.key()+ " " + record.value());
		 	  
		 	    }
		 	   consumer.commitSync();
	     }catch(Exception ex) {
         System.out.println("Exception " + ex);
	    	 ex.printStackTrace();
	    	 consumer.close();
	     }
	}    
     
}

