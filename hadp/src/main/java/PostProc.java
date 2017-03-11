import java.io.*;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Collections;

/**
 * Created by Zijian on 3/11/17.
 */
public class PostProc {
    public static void main(String[] args) throws IOException {
        if(args.length != 1){
            throw new IllegalArgumentException("Expecting one argument: input file path");
        }
        String line;
        int sum = 0;
        int mostCount = -1;
        String mostCommon = "";
        ArrayList<Integer> listOfCount = new ArrayList<>();
        try {
            InputStream fis = new FileInputStream(args[0]);
            InputStreamReader isr = new InputStreamReader(fis, Charset.forName("UTF-8"));
            BufferedReader br = new BufferedReader(isr);
            while ((line = br.readLine()) != null) {
                String [] words = line.split("\t");
                int cnt = Integer.parseInt(words[1]);
                sum += cnt;
                listOfCount.add(cnt);
                if(cnt > mostCount){
                    mostCount = cnt;
                    mostCommon = words[0];
                }
            }
            System.out.println("In total " + listOfCount.size() + " bigrams.");
            System.out.println("The most common bigram is " + mostCommon);
//            Collections.sort(listOfCount);
            int tmpSum = 0;
            for(int i = 0; i < listOfCount.size(); i++){
                tmpSum += listOfCount.get(i);
                if(tmpSum >= sum/10.0){
                    System.out.println("The number of bigrams required to add up to 10% of all bigrams is " + i);
                    break;
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }

    }
}
