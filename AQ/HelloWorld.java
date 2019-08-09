/******************************************************************************
 *  Compilation:  javac HelloWorld.java
 *  Execution:    java HelloWorld
 *
 *  Prints "Hello, World". By tradition, this is everyone's first program.
 *
 *  % java HelloWorld
 *  Hello, World
 *
 *  These 17 lines of text are comments. They are not part of the program;
 *  they serve to remind us about its properties. The first two lines tell
 *  us what to type to compile and test the program. The next line describes
 *  the purpose of the program. The next few lines give a sample execution
 *  of the program and the resulting output. We will always include such 
 *  lines in our programs and encourage you to do the same.
 *
 ******************************************************************************/

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.*;
public class HelloWorld {

    public static void main(String[] args)  throws IOException {
        // Prints "Hello, World" to the terminal window.
       
       String [] Command = null;
//node invokefunc-body.js https://7ytvggn7rwq.us-phoenix-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.phx.aaaaaaaaaakdypudz72ygs2t6igokv63endmjvm34rpzfq5s3hoty6embtfq/actions/invoke kickoffdrone.json
        if (System.getProperty("os.name").equals("Linux")) {
                Command = new String[4];
                Command[0] = "node";
                Command[1] = "InvokeFn/invokefunc-body.js";
                Command[2] = "https://7ytvggn7rwq.us-phoenix-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.phx.aaaaaaaaaakdypudz72ygs2t6igokv63endmjvm34rpzfq5s3hoty6embtfq/actions/invoke";
                Command[3] = "InvokeFn/kickoffdrone.json";
                  System.out.println(Command);
        
                }
        if (System.getProperty("os.name").equals("Mac OS X")) {
                Command = new String[4];
                Command[0] = "node";
                //Command[1] ="-v";
                 Command[1] = "InvokeFn/invoke_drone.js";
                 Command[2] = "https://7ytvggn7rwq.us-phoenix-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.phx.aaaaaaaaaakdypudz72ygs2t6igokv63endmjvm34rpzfq5s3hoty6embtfq/actions/invoke";
                Command[3] = "InvokeFn/kickoffdrone.json";
                }
        if (System.getProperty("os.name").equals("Solaris")) {
                Command = new String[2];
                Command[0] = "df";
                Command[1] = "-k";
                }
        if (Command == null) {
                System.out.print("Can't find free space on ");
                System.out.println(System.getProperty("os.name"));
                System.exit(1);
                }
      
        Process Findspace = Runtime.getRuntime().exec(Command);

        BufferedReader Resultset = new BufferedReader(
                        new InputStreamReader (
                        Findspace.getInputStream()));

        String line;
        while ((line = Resultset.readLine()) != null) {
                System.out.println(line);
                }
    }

}