import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;
import java.util.Map;
import java.util.HashMap;

public class Totals{
	public static void main(String[] args) throws IOException{
		
		File inputFile = new File(args[0]); // opens the file
		FileWriter outputFile = new FileWriter(args[1]);
		Scanner fileReader;
		PrintWriter fileWriter;
		// the map used for the numbers and totals
		Map <Integer, Double> map = new HashMap<Integer, Double>();
		Map <Integer, Integer> cmap = new HashMap<Integer, Integer>();
		int taxa = 0;
		int taxacount = 0;
		int appears = 0;
		double total = 1.0;
		double total2 = 0.0;
		int counter = 0;
		//double test = 0.0;
		//double test2 = 0.0;
		
		try {
			fileReader = new Scanner(inputFile);
			fileWriter = new PrintWriter(outputFile);
			
			// reads through every line in the file
			while (fileReader.hasNextLine()){
				String line = fileReader.nextLine();
				
				//splits the line into its two parts
				String[] parts = line.split(":");
				taxa = Integer.parseInt(parts[0]);
				total = Double.parseDouble(parts[1]);
				if (taxa > counter){
					counter = taxa;
				}
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
			fileWriter.println(map.size());
			for (int i = 0; i <= counter; i++){
				if (map.containsKey(i)){
					total2 = map.get(i);
					appears = cmap.get(i);
					int k = map.size();
					int n = 3;
				
					fileWriter.print(i + ":");
					fileWriter.print(total2 + ":");
					fileWriter.println(appears);
				}

			}
			
			fileWriter.close();
		}catch (FileNotFoundException e){
			System.out.println("File not found.");
		}
				
	}

}
