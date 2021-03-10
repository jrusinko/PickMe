
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;
import java.util.ArrayList;
 

// computes the weights for the quartets
public class IgnoreTaxa{
	public static void main(String [] args) throws IOException{
		try{
		File inputFile1 = new File(args[0]); // weighted quartets
		File inputFile2 = new File(args[1]); // bad taxa
		FileWriter outputFile = new FileWriter(args[2]);
		Scanner fileReader1, fileReader2;
		PrintWriter fileWriter;
		ArrayList<String> taxa = new ArrayList<String>();
		
		
			fileReader2 = new Scanner(inputFile2);
			fileWriter = new PrintWriter(outputFile);
			fileReader1 = new Scanner(inputFile1);
			
			
			// gets the bad taxa and puts them in the arraylist taxa
			while (fileReader2.hasNextLine()){
				String a = fileReader2.nextLine();
				taxa.add(a);
			}
			// goes through the file of quartet weights and ignores ones with bad 				taxa
			while (fileReader1.hasNextLine()){
				String line = fileReader1.nextLine();
				String[] qtaxa = line.split("[,:|]");
				boolean drop = (taxa.contains(qtaxa[0]) || taxa.contains(qtaxa[1])
						|| taxa.contains(qtaxa[2]) || taxa.contains(qtaxa[3]));

				if (!drop){
					fileWriter.println(line);
				}				
	  
			}
			fileWriter.close();
		   }
		
		catch(FileNotFoundException e){
			System.out.println("That file does not exist");
		}
		
		
		
		
	}
	
}
