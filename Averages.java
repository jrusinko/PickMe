
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;
import java.util.Map;
import java.util.HashMap;

// computes the weights for the quartets
public class Averages{
	public static void main(String [] args) throws IOException{
	
		File inputFile = new File(args[0]);
		FileWriter outputFile = new FileWriter(args[1]);
		Scanner fileReader;
		PrintWriter fileWriter;
		
		
		try{
			fileReader = new Scanner(inputFile);
			fileWriter = new PrintWriter(outputFile);
			
			String firstline = fileReader.nextLine();
			int numQuartets = Integer.parseInt(firstline);
	//		double combin = ((numQuartets-1)*(numQuartets-2)*(numQuartets-3))/6;
	//		combin = combin * 3.0;
			
			// reads through every line of the file
			while (fileReader.hasNextLine()){
				String line = fileReader.nextLine();
				String[] sections = line.split(":");
				int taxa = Integer.parseInt(sections[0]);
				double total = Double.parseDouble(sections[1]);
				double avg = total / Double.parseDouble(sections[2]);
				fileWriter.println(taxa + ":" + avg);
			}
			fileWriter.close();
			
		}catch(FileNotFoundException e){
			System.out.println("That file does not exist");
		}
		
		
		
		
	}
	
}
