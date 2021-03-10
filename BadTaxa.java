
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;
import java.util.Map;
import java.util.HashMap;
import java.io.BufferedWriter;

// computes the weights for the quartets
public class BadTaxa{
	public static void main(String [] args) throws IOException{
	
		File inputFile = new File(args[0]);

		FileWriter outputFile = new FileWriter(args[1]);
		FileWriter oldlevel = new FileWriter("oldlevel.txt");

		FileWriter nextlevel = new FileWriter("nextlevel.txt");
		
		FileWriter forGraph = new FileWriter("weightlist",true);
		int inp = Integer.parseInt(args[2]);

		if(inp <=39){	

		double minscore = 2;

		double i = 1000.0;
		double[] rvalues = {0.0116,0.0291,0.0587,0.1036,0.1670,0.2521,0.3620,0.4273,0.4848,0.5,0.5074,0.5185,0.5374,0.5659,0.6063,0.6604,0.7304,0.7719,0.8085,0.8182,0.8209,0.825,0.832,0.8425,0.8574,0.8773,0.9031,0.9184,0.9319,0.9355,0.9365,0.9381,0.9407,0.9448,0.9504,0.9580,0.9679,0.9737,0.9788,0.9802};
	        i = rvalues[inp];

		Scanner fileReader;
		PrintWriter fileWriter;
		
		try{
			fileReader = new Scanner(inputFile);
			fileWriter = new PrintWriter(outputFile);
			
			
			// reads through every line of the file
			while (fileReader.hasNextLine()){
				String line = fileReader.nextLine();
				String[] sections = line.split(":");
				double average = Double.parseDouble(sections[1]);
				if (average <= i){
				 	fileWriter.println(sections[0]);

		//	fileWriter.println(line);

				}
				else if (average < minscore){
				   minscore = average;
				}
			}
			fileWriter.close();

			
		}catch(FileNotFoundException e){
			System.out.println("That file does not exist");
		}

			
			int level = inp;
			for (int j = level; j <= 39;j++){
			if (minscore > rvalues[j]){
			    level = j+1;
			    }
			}
			fileWriter = new PrintWriter(nextlevel);
			fileWriter.println(level);
			fileWriter.close();
			fileWriter = new PrintWriter(oldlevel);
			fileWriter.println(inp);
			fileWriter.close();
			
		
			fileReader = new Scanner(inputFile);
			fileWriter = new PrintWriter(forGraph);
			
			
			// reads through every line of the file
			while (fileReader.hasNextLine()){
				String line = fileReader.nextLine();
				String[] sections = line.split(":");
				double average = Double.parseDouble(sections[1]);
				if (average <= i){
					fileWriter.println(line);
                                         }

					
			}
			fileWriter.close();
			

	
		}
		
		else{
		Scanner fileReader;
		PrintWriter fileWriter;
		
		try{
			fileReader = new Scanner(inputFile);
			fileWriter = new PrintWriter(outputFile);
	
	
			// reads through every line of the file
			while (fileReader.hasNextLine()){
				String line = fileReader.nextLine();
				String[] sections = line.split(":");
				fileWriter.println(sections[0]);
			}
			fileWriter.close();
		
		}catch(FileNotFoundException e){
			System.out.println("That file does not exist");
		}

			fileReader = new Scanner(inputFile);
			fileWriter = new PrintWriter(forGraph);
			
			// reads through every line of the file
			while (fileReader.hasNextLine()){
				String line = fileReader.nextLine();
				fileWriter.println(line);
				}
			
			fileWriter.close();


		}
	
		
	  	
	}
	
}
