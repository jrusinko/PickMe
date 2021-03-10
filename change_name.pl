#use strict;
use warnings; 
use Getopt::Long;
#author: Allison Doherty

my $infile = $ARGV[0];
my $valsout = $ARGV[1];
my $quartout = $ARGV[2];

#goes through every line of the file
open (my $in, '<:encoding(UTF-8)', $infile) or die "Could not open file '$infile' $!";
open (my $vout, '>', $valsout) or die "Could not open file '$valsout' $!";
open (my $qout, '>', $quartout) or die "Could not open file '$valsout' $!";
my @values;
my $inc = 0;
my %taxon_to_id;
while (my $line = <$in>){
	chomp $line;
	#splits the line into sections
	my ($quart, $val1, $val2) = split(/\:/,$line);
	#splits the quartet into its four values
	my ($first, $second) = split(/\|/,$quart);
	my ($firstval, $secondval) = split(/\,/,$first);
	my ($thirdval, $fourthval) = split(/\,/,$second);
	#if the value isn't in the list already, add it
	my $newval = 1;
	my $size = @values;
	for (my $i = 0; $i < $size; $i++){
		if ($values[$i] eq $firstval){
			$newval = 0;
			last;
		}
	}
	if ($newval){
		push @values, $firstval;
		$taxon_to_id{$firstval} = $inc;
		print $vout "$firstval:$taxon_to_id{$firstval}\n";
		$inc++;
	}
	$newval = 1;
	$size = @values;
	for ($i = 0; $i < $size; $i++){
		if ($values[$i] eq $secondval){
			$newval = 0;
			last;
		}
	}
	if ($newval){
		push @values, $secondval;
		$taxon_to_id{$secondval} = $inc;
		print $vout "$secondval:$taxon_to_id{$secondval}\n";
		$inc++;
	}
	$size = @values;
	$newval = 1;
	for ($i = 0; $i < $size; $i++){
		if ($values[$i] eq $thirdval){
			$newval = 0;
			last;
		}
	}
	if ($newval){
		push @values, $thirdval;
		$taxon_to_id{$thirdval} = $inc;
		print $vout "$thirdval:$taxon_to_id{$thirdval}\n";
		$inc++;
	}
	$size = @values;
	$newval = 1;
	for ($i = 0; $i < $size; $i++){
		if ($values[$i] eq $fourthval){
			$newval = 0;
			last;
		}
	}
	if ($newval){
		push @values, $fourthval;
		$taxon_to_id{$fourthval} = $inc;
		print $vout "$fourthval:$taxon_to_id{$fourthval}\n";
		$inc++;
	}
	#print the new file with the renamed quartets
	print $qout "$taxon_to_id{$firstval},$taxon_to_id{$secondval}|$taxon_to_id{$thirdval},$taxon_to_id{$fourthval}:";
	print $qout "$val1:$val2\n";
	
}
close $in;
close $vout;
close $qout;



