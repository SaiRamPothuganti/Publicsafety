import java.util.Properties;
import org.apache.kafka.clients.producer.*;

public class Producer1 {
public static void main(String[] args) {
	KafkaProducer<String,String> prod = null;
   int msgCnt = Integer.parseInt(args[0]);
	 Properties props = new Properties();
	 props.put("oracle.service.name", "bug9.regress.rdbms.dev.us.oracle.com");
	 props.put("oracle.instance.name", "bug9");
     props.put("oracle.user.name", "aq");
     props.put("oracle.password", "aq");
	 props.put("bootstrap.servers", "den02tgo:1521");
	 props.put("retries", 0);
	 props.put("batch.size", 5000);
	 props.put("linger.ms", 1000);
	 props.put("buffer.memory", 3355443);
	 props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
	 props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");	
	  
	 prod=new KafkaProducer<String, String>(props);
	 try {
       System.out.println("Producing messages " + msgCnt);
			 for(int j=0;j<msgCnt; j++) {
				 prod.send(new ProducerRecord<String, String>("TOPIC2" , Integer.toString(j)+ "000","This is new message"+j));
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

