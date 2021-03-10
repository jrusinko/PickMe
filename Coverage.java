import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;
import java.util.Map;
import java.util.HashMap;
import java.io.BufferedWriter;

// Adds taxa coverage to weightsfile
public class Coverage{
	public static void main(String[] args) throws IOException{
	
		File iFile = new File(args[0]);
		File wFile = new File(args[1]);
		File oFile = new File(args[2]);
	
		
			Scanner wfileReader;
			
			PrintWriter fileWriter;
			
			
			wfileReader = new Scanner(wFile);
			fileWriter = new PrintWriter(oFile);
			
			
			// reads through every line of weightsfile
			while (wfileReader.hasNextLine()){
				String line = wfileReader.nextLine();
				String[] sections = line.split(":");
				int Count = 0;
				int Appears = 0;
				Scanner fileReader;
				fileReader = new Scanner(iFile);
				while (fileReader.hasNextLine()){
				   String tree = fileReader.nextLine();
				   String[] taxa = tree.split("[(,):;]");
				   Count++;
				   for(int j=0;j < taxa.length;j++){
				      if (taxa[j].equals(sections[0])){	
					Appears++;}
				       }
				    
                                }
			Double cov = ((double)Appears/Count);
			fileWriter.println(line + ":" + String.valueOf(cov));
			}
			fileWriter.println("Total gene trees evaluated = " + String.valueOf(Count));
			fileWriter.close();	
	  	
	
	}
}