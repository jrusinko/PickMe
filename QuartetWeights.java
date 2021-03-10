import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;

// computes the weights for the quartets
public class QuartetWeights{
	public static void main(String [] args) throws IOException{
		int n=0;
		int numQ=0;
		double weight = 0.0;
		String numberOnly ="";
		String quartets="";
		int [] leaves = new int [4];
		int totaltaxa;
		File inputFile = new File(args[0]);	// open the file (ETreeQ or TTreeQ)
		FileWriter outputFile = new FileWriter(args[1]); // file we're writing to
		Scanner fileReader;
		PrintWriter fileWriter;

		try {
			fileReader=new Scanner (inputFile);
			fileWriter = new PrintWriter (outputFile);
			
			// reads through every line in the file
			while(fileReader.hasNextLine()){
				String numsTrees=fileReader.nextLine();
				//System.out.println("Line being read in: " + numsTrees);
				// not sure if we need this or not
				numsTrees=numsTrees.replace("_0", "");
				//System.out.println("Got a tree");
				// goes through all of the sections in the string
				for(int i=0;i<numsTrees.length();i++){
				
					if(i+1<numsTrees.length() && numsTrees.substring(i,
					 				i+1).equals(":")){
									
						//System.out.println("computing the weight");
						// computes the weight
						String numbers = numsTrees.substring(i+1);
						String[] twonumbers = numbers.split(":");
						numQ = Integer.parseInt(twonumbers[0]);
						totaltaxa = Integer.parseInt(twonumbers[1]);
						//System.out.println(weight);
						
						//**********integral main program************//
						int k = numQ;
		
						// the base of the weight formula
						double numerator = 	TrapezoidalRule.integrate((1.0/3.0),1,50,k, totaltaxa);
						double denominator = TrapezoidalRule.integrate(0,1,50,k, totaltaxa);
						double base = numerator/denominator;
		
						//System.out.println("base: " + base);
		
						// the other part of the weight formula
						// if k is an even number, do it normally
						double other = 0.0;
						// if ik is even, compute normally
						if (k%2==0){
							int k2 = (1000-k)/2;
							double numerator2 = TrapezoidalRule.integrate((1.0/3.0),1,50,k2, totaltaxa);
							double denominator2 = TrapezoidalRule.integrate(0,1,50,k2, totaltaxa);
							other = numerator2/denominator2;
						}
						// if k is uneven, split it up and take the average
						else{
							// lower
							int k3 = (1000-k-1)/2;
							double numerator3 = TrapezoidalRule.integrate((1.0/3.0),1,50,k3, totaltaxa);
							double denominator3 = TrapezoidalRule.integrate(0,1,50,k3, totaltaxa);
							double other1 = numerator3/denominator3;
							// upper
							int k4 = (1000-k+1)/2;
							double numerator4 = TrapezoidalRule.integrate((1.0/3.0),1,50,k4, totaltaxa);
							double denominator4 = TrapezoidalRule.integrate(0,1,50,k4, totaltaxa);
							double other2 = numerator4/denominator4;
							// average of the two
							other = (other1+other2)/2;
						}
						//System.out.println("other: " + other);

						// computes the weight
						weight = base / (2 * other + base);
						//System.out.println("weight: " + weight);
						
						//***********end of integral main program*************//
						
						quartets = numsTrees.substring(0, i);		
						break; // once we find the ":" we don't have to keep searching			
					}
				}
				
				numberOnly=quartets.replaceAll("[^-?0-9]+", " ");
				String[] parts = numberOnly.split(" ");
				
				for(int j = 0; j < parts.length; j++) {
					leaves[j]=Integer.parseInt(parts[j]);
				}
				

				fileWriter.println(leaves[0]+","+leaves[1]+"|"+
										leaves[2]+","+leaves[3]+":" + weight);	
			}
			fileWriter.close();
			
		}catch (FileNotFoundException e) {
			System.out.println("Sorry there's a mistake.");
		}
	}
	
	//**** inner class for the integration ****//
	static class TrapezoidalRule{
		/**
		 * standard normal distribution density function.
		 * replace with any sufficiently smooth function
		 * @param x
		 * @return
		 */
		static double f(double p, int k, int totaltaxa){
			// computes p to the exponent of k
			double exponent1 = 1;
			for (int i = 0; i < k; i++){
				exponent1 = exponent1 * p;
			}
			// computes 1-p to the exponent of 1000-k
			double exponent2 = 1;
			for (int j = 0; j < (totaltaxa-k); j++){
				exponent2 = exponent2 * (1-p);
			}
			
			return (exponent1)*(exponent2);
		}
		
		/**
		 * integrate f from a to b using the trapezoidal rule.
		 * increase n for more precision
		 * @param a
		 * @param b
		 * @param N
		 * @return
		 */
		static double integrate(double a, double b, int N, int k, int tot){
			double h = (b-a) / N;
			double sum = 0.5 * (f(a, k, tot) + f(b, k, tot));
		//	System.out.println(f(a,k));
		//	System.out.println(f(b,k));
			for (int i = 1; i < N; i++){
				double x = a + h * i;
				sum = sum + f(x, k, tot);
			//	System.out.println(f(x,k));
			}
			return sum * h;
		}
		
		
	}
}
