#use strict;
use warnings;
use Getopt::Long;

my $infile = $ARGV[0];
my $namingsystem = $ARGV[1];
my $outfile = $ARGV[2];

open (my $names, '<:encoding(UTF-8)', $namingsystem) or die "Could not open file '$namingsystem' $!";
#goes through every line of the file
my %taxon_to_id;
while (my $line = <$names>){
	chomp $line;
	my ($orig, $new) = split(/\:/,$line);
	$taxon_to_id{$new} = $orig;
	#print "new: $new orig: $taxon_to_id{$new}\n";
}
close $names;
open (my $in, '<:encoding(UTF-8)', $infile) or die "Could not open file '$infile' $!";
open (my $out, '>', $outfile) or die "Could not open file '$outfile' $!";
while (my $tree = <$in>){
	$length = length $tree;
	chomp $length;
	my $num = 0;
	for (my $i = 0; $i < $length; $i++){
		my $nth = substr($tree, $i, 1);
		if (($nth eq '1') || ($nth eq '2') || ($nth eq '3') || ($nth eq '4') || 
			($nth eq '5') || ($nth eq '6') || ($nth eq '7') || ($nth eq '8') || 
			($nth eq '9') || ($nth eq '0')){
			$num = $nth;
			#checks to see if the next digit is also a number
			my $next = substr($tree, $i+1, 1);
			if (($next eq '1') || ($next eq '2') || ($next eq '3') || ($next eq '4') || 
				($next eq '5') || ($next eq '6') || ($next eq '7') || ($next eq '8') || 
				($next eq '9') || ($next eq '0')){
				$num .= $next;
				$i++;
			}
			#finds the value corresponding to that number and prints that to the file
			print $out "$taxon_to_id{$num}";
		}
		else{
			print $out "$nth";
		}
	}
	print $out "\n";
}

close $in;
close $out;
