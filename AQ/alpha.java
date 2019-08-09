// Java program to illustrate the 
// use of HttpURLConnection 
// to retrieve the emotion score 
// of image using Microsoft Emotion api 

import java.io.BufferedReader; 
import java.io.IOException; 
import java.io.InputStream; 
import java.io.InputStreamReader; 
import java.io.OutputStream; 
import java.net.HttpURLConnection; 
import java.net.URL; 
import org.json.simple.JSONObject; 

public class httpconclass 
{ 
	public static void main(String args[]) throws IOException 
	{ 
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in)); 
		int n = Integer.parseInt(br.readLine()); 
		String key = "833921b016964f95905442e0fab0c229"; 
		JSONObject ezm; 
	
		while (n-- > 0) 
		{ 
			String image = br.readLine(); 
			ezm = new JSONObject(); 
			ezm.put("url", image); 
			try
			{ 

				// url for microsoft congnitive server. 
				URL url = 
			new URL("https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize"); 
				HttpURLConnection con = 
						(HttpURLConnection) url.openConnection(); 

				// set the request method and properties. 
				con.setRequestMethod("POST"); 
				con.setRequestProperty("Ocp-Apim-Subscription-Key", key); 
				con.setRequestProperty("Content-Type", "application/json"); 
				con.setRequestProperty("Accept", "application/json"); 

				// As we know the length of our content, 
				// the following function sets the fixed 
				// streaming mode length 83 bytes. If 
				// content length not known, comment the below line. 
				con.setFixedLengthStreamingMode(83); 

				// set the auto redirection to true 
				HttpURLConnection.setFollowRedirects(true); 

				// override the default value set by 
				// the static method setFollowRedirect above 
				con.setInstanceFollowRedirects(false); 

				// set the doOutput to true. 
				con.setDoOutput(true); 

				OutputStream out = con.getOutputStream(); 
				// System.out.println(ezm.toString().getBytes().length); 

				// write on the output stream 
				out.write(ezm.toString().getBytes()); 
				InputStream ip = con.getInputStream(); 
				BufferedReader br1 = 
						new BufferedReader(new InputStreamReader(ip)); 

				// Print the response code 
				// and response message from server. 
				System.out.println("Response Code:"
										+ con.getResponseCode()); 
				System.out.println("Response Message:"
									+ con.getResponseMessage()); 

				// uncomment the following line to 
				// print the status of 
				// FollowRedirect property. 
				// System.out.println("FollowRedirects:" 
				//			 + HttpURLConnection.getFollowRedirects()); 

				// to print the status of 
				// instanceFollowRedirect property. 
				System.out.println("InstanceFollowRedirects:"
								+ con.getInstanceFollowRedirects()); 

				// to print the 1st header field. 
				System.out.println("Header field 1:"
									+ con.getHeaderField(1)); 

				// to print if usingProxy flag set or not. 
				System.out.println("Using proxy:" + con.usingProxy()); 

				StringBuilder response = new StringBuilder(); 
				String responseSingle = null; 
				while ((responseSingle = br1.readLine()) != null) 
				{ 
					response.append(responseSingle); 
				} 
				String xx = response.toString(); 
				System.out.println(xx); 

			} catch (Exception e) 
			
			{ 
				System.out.println(e.getMessage()); 
			} 

		} 
	} 

} 
