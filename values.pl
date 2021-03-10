#use strict;
use warnings;
use Getopt::Long;
#author: Allison Doherty
my $infile = $ARGV[0];
my $outfile = $ARGV[1];

#creates an array
my @taxa;

open (my $in, '<:encoding(UTF-8)', $infile) or die "Could not open file '$infile' $!";
open (my $out, '>', $outfile) or die "Could not open file '$outfile' $!";
#goes through every line of the file
my $firstnum;
my $secondnum;
my $thirdnum;
my $fourthnum;
while (my $line = <$in>){
	chomp $line;
	#searches for the four numbers
	my $nth;
	my $nth2;
	my $counter = 0;
	my $linelength = length $line;
	for (my $i=0; $i < $linelength; $i++){
		$nth = substr($line, $i, 1);
		if (($nth eq '1') || ($nth eq '2') || ($nth eq '3') || ($nth eq '4') || ($nth eq '5') ||
			($nth eq '6') || ($nth eq '7') || ($nth eq '8') || ($nth eq '9') || ($nth eq '0')){
			$firstnum = $nth;
			#checks to see what the next number is 
			$nth2 = substr($line, $i+1, 1);
			if (($nth2 eq '1') || ($nth2 eq '2') || ($nth2 eq '3') || ($nth2 eq '4') || ($nth2 eq '5') ||
			($nth2 eq '6') || ($nth2 eq '7') || ($nth2 eq '8') || ($nth2 eq '9') || ($nth2 eq '0')){
				$firstnum .= $nth2;
			}
			$i++;
			$counter++;
			last;
		}
		$counter++;
	}
	$counter++;
	#searches for the second number
	for (my $i=$counter; $i < $linelength; $i++){
		$nth = substr($line, $i, 1);
		if (($nth eq '1') || ($nth eq '2') || ($nth eq '3') || ($nth eq '4') || ($nth eq '5') ||
			($nth eq '6') || ($nth eq '7') || ($nth eq '8') || ($nth eq '9') || ($nth eq '0')){
			$secondnum = $nth;
			#checks to see what the next number is 
			$nth2 = substr($line, $i+1, 1);
			if (($nth2 eq '1') || ($nth2 eq '2') || ($nth2 eq '3') || ($nth2 eq '4') || ($nth2 eq '5') ||
			($nth2 eq '6') || ($nth2 eq '7') || ($nth2 eq '8') || ($nth2 eq '9') || ($nth2 eq '0')){
				$secondnum .= $nth2;
			}
			$i++;
			$counter++;
			last;
		}
		$counter++;
	}
	$counter++;
	#searches for the third number
	for (my $i=$counter; $i < $linelength; $i++){
		$nth = substr($line, $i, 1);
		if (($nth eq '1') || ($nth eq '2') || ($nth eq '3') || ($nth eq '4') || ($nth eq '5') ||
			($nth eq '6') || ($nth eq '7') || ($nth eq '8') || ($nth eq '9') || ($nth eq '0')){
			$thirdnum = $nth;
			#checks to see what the next number is 
			$nth2 = substr($line, $i+1, 1);
			if (($nth2 eq '1') || ($nth2 eq '2') || ($nth2 eq '3') || ($nth2 eq '4') || ($nth2 eq '5') ||
			($nth2 eq '6') || ($nth2 eq '7') || ($nth2 eq '8') || ($nth2 eq '9') || ($nth2 eq '0')){
				$thirdnum .= $nth2;
			}
			$i++;
			$counter++;
			last;
		}
		$counter++;
	}
	$counter++;
	#searches for the fourth number
	for (my $i=$counter; $i < $linelength; $i++){
		$nth = substr($line, $i, 1);
		if (($nth eq '1') || ($nth eq '2') || ($nth eq '3') || ($nth eq '4') || ($nth eq '5') ||
			($nth eq '6') || ($nth eq '7') || ($nth eq '8') || ($nth eq '9') || ($nth eq '0')){
			$fourthnum = $nth;
			#checks to see what the next number is 
			$nth2 = substr($line, $i+1, 1);
			if (($nth2 eq '1') || ($nth2 eq '2') || ($nth2 eq '3') || ($nth2 eq '4') || ($nth2 eq '5') ||
			($nth2 eq '6') || ($nth2 eq '7') || ($nth2 eq '8') || ($nth2 eq '9') || ($nth2 eq '0')){
				$fourthnum .= $nth2;
			}
			$i++;
			$counter++;
			last;
		}
		$counter++;
	}

	#prints onto the new file the number taxa as well as the total value
	my ($line, $weight) = split(/\:/,$line);

	print $out "$firstnum:$weight\n";
	print $out "$secondnum:$weight\n";
	print $out "$thirdnum:$weight\n";
	print $out "$fourthnum:$weight\n";
}
close $in;
close $out;
