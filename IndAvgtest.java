import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;
import java.util.Map;
import java.util.HashMap;

public class IndAvgtest{
	public static void main(String[] args) throws IOException{
		
		File inputFile = new File(args[0]); // opens the file
		FileWriter outputFile = new FileWriter(args[1]);
		Scanner fileReader;
		PrintWriter fileWriter;
		// the map used for the numbers and totals
		Map <String, Double> map = new HashMap<String, Double>();
		Map <String, Integer> cmap = new HashMap<String, Integer>();
		String taxa = "cat";
		int taxacount = 0;
		int appears = 0;
		double total = 1.0;
		double total2 = 0.0;
		double avg = 0.0;

		
		try {
			fileReader = new Scanner(inputFile);
			fileWriter = new PrintWriter(outputFile);
			
			// reads through every line in the file
			while (fileReader.hasNextLine()){
				String line = fileReader.nextLine();
				//splits the line into its two parts
				String[] parts = line.split("[,:|]");
				total = Double.parseDouble(parts[4]);
				for (int i = 0; i < 4; i++){
				taxa = parts[i];
				// sees if the number is in the map yet.  If it's not, add it.
				if (map.containsKey(taxa)){
					// adds the total 
					map.put(taxa, map.get(taxa) + total);
					cmap.put(taxa,cmap.get(taxa)+1);
				}
				else{
					map.put(taxa,total);
					cmap.put(taxa,1);
				}
			
			        }
			}
	//		fileWriter.println(map.size());
			for (String i : map.keySet()){
					total2 = map.get(i);
					appears = cmap.get(i);
				        avg = total2 / appears;
					fileWriter.print(i + ":");
					fileWriter.println(avg);
	//				fileWriter.println(appears);
				

			}
			fileWriter.close();
		}catch (FileNotFoundException e){
			System.out.println("File not found.");
		}
				
	}

}
