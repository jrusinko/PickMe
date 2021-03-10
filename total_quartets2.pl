#use strict;
#use warnings; 
use Getopt::Long;
#author: Allison Doherty

my $infile = $ARGV[0];
my $outfile = $ARGV[1];

#creates an array of every line of the file
my @lines;
open (my $fh, '<:encoding(UTF-8)', $infile) or die "Could not open file '$infile' $!";
while (my $line = <$fh>){
	chomp $line;
	my ($quart, $extra) = split(/\./,$line);
	push @lines, $quart;
}
close $fh;

open (my $in, '<:encoding(UTF-8)', $infile) or die "Could not open file '$infile' $!";
open (my $out, '>', $outfile) or die "Could not open file '$outfile' $!";
#goes through every line of the file
while (my $line = <$in>){
	chomp $line;
	#print $out "line: $line\n";
	#searches for the four sections
	#splits up the value by the quartet
	my ($quartet, $value) = split(/\:/,$line);
	my ($first, $second) = split(/\|/,$quartet);
	my ($firstvalue, $secondvalue) = split(/\,/, $first);
	my ($thirdvalue, $fourthvalue) = split(/\,/, $second);
	#splits up these values into single digits
	my @secondval = split("", $secondvalue);
	my @thirdval = split("", $thirdvalue);
	my @fourthval = split("", $fourthvalue);
	#determines the second quartet format we're looking for
	my $secondquartet = "$firstvalue,$thirdvalue|";
	my $index = 0;
	my $boolean = 1;
	while($boolean){
		if ($secondval[$index] lt $fourthval[$index]){
			$secondquartet .= "$secondvalue,$fourthvalue";
			last;
		}
		elsif ($secondval[$index] gt $fourthval[$index]){
			$secondquartet .= "$fourthvalue,$secondvalue";
			last;
		}
		else{
			if (@secondval eq $index){
				$secondquartet .= "$secondvalue,$fourthvalue";
				last;
			}
			elsif (@fourthval eq $index){
				$secondquartet .= "$fourthvalue,$secondvalue";
				last;
			}
			else{
				$index++;
			}
		}
	}
	#print $out "second quartet: $secondquartet\n";
	#determines the third quartet format we're looking for
	my $thirdquartet = "$firstvalue,$fourthvalue|";
	$index = 0;
	$boolean = 1;
	while ($boolean){
		if ($secondval[$index] lt $thirdval[$index]){
			$thirdquartet .= "$secondvalue,$thirdvalue";
			last;
		}
		elsif ($secondval[$index] gt $thirdval[$index]){
			$thirdquartet .= "$thirdvalue,$secondvalue";
			last;
		}
		else{
			if (@secondval eq $index){
				$thirdquartet .= "$secondvalue,$thirdvalue";
				last;
			}
			elsif (@thirdval eq $index){
				$thirdquartet .= "$thirdvalue,$secondvalue";
				last;
			}
			else{
				$index++;
			}
		}
	}
	#print $out "third quartet: $thirdquartet\n";	

	#does a binary search to see where the second quartet is 
	my $high = @lines;
	my $low = 0;
	my $found_key = 0;
	my $mid;
	my $secondtotal = 0;
	#splits the quartet being compared into its four parts
	my @origquartetsplit = split(/\|/,$secondquartet);
	my @origfirstsecond = split(/\,/,$origquartetsplit[0]);
	my @origthirdfourth = split(/\,/,$origquartetsplit[1]);
	my @firstquartetarray = ("","");
	my $quartet1 = 0;
	my $value1 = 0;
	my @quartet1split = ("","");
	my @listfirstsecond = ("","");
	my @listthirdfourth = ("","");
	while (($low <= $high) && !$found_key){
		$mid = int(($low + $high) / 2);
		#gets the right format
		@firstquartetarray = split(/\:/,$lines[$mid]);
		$quartet1 = $firstquartetarray[0];
		$value1 = $firstquartetarray[1];
		#splits the quartet1 into four values (listfirstnum - listfourthnum)
		#and the secondquartet into four values
		@quartet1split = split(/\|/,$quartet1);
		#splits that into the four sections
		@listfirstsecond = split(/\,/,$quartet1split[0]);
		@listthirdfourth = split(/\,/,$quartet1split[1]);
		#if it finds the quartet in the array of quartets 
		if (($listfirstsecond[0] eq $origfirstsecond[0])&&($listfirstsecond[1] eq $origfirstsecond[1])&&
			($listthirdfourth[0] eq $origthirdfourth[0])&&($listthirdfourth[1] eq $origthirdfourth[1])){
			$found_key = 1;
			$secondtotal = $value1;
		}
		#sees if the quartet is less than or greater than the one we're looking for
		elsif ($origfirstsecond[0] lt $listfirstsecond[0]){
			$high = $mid-1;
		}
		elsif ($listfirstsecond[0] lt $origfirstsecond[0]){
			$low = $mid+1;
		}
		elsif ($origfirstsecond[1] lt $listfirstsecond[1]){
			$high = $mid-1;
		}
		elsif ($listfirstsecond[1] lt $origfirstsecond[1]){
			$low = $mid+1;
		}
		elsif ($origthirdfourth[0] lt $listthirdfourth[0]){
			$high = $mid-1;
		}
		elsif ($listthirdfourth[0] lt $origthirdfourth[0]){
			$low = $mid+1;
		}
		elsif ($origthirdfourth[1] lt $listthirdfourth[1]){
			$high = $mid-1;
		}
		else{
			$low = $mid+1;
		}
	}

	#does a binary search to see where the third quartet is
	$high = @lines;
	$low = 0;
	$found_key = 0;
	my $thirdtotal = 0;
	#splits the quartet being compared into its four parts
	my @orig2quartetsplit = split(/\|/,$thirdquartet);
	my @orig2firstsecond = split(/\,/,$orig2quartetsplit[0]);
	my @orig2thirdfourth = split(/\,/,$orig2quartetsplit[1]);
	my @secondquartetarray = ("","");
	my $quartet2 = 0;
	my $value2 = 0;
	my @quartet2split = ("","");
	my @list2firstsecond = ("","");
	my @list2thirdfourth = ("","");
	while (($low <= $high) && !$found_key){
		$mid = int(($low + $high) / 2);
		#gets the right format
		@secondquartetarray = split(/\:/,$lines[$mid-1]);
		$quartet2 = $secondquartetarray[0];
		$value2 = $secondquartetarray[1];
		#splits the quartet1 into four values (listfirstnum - listfourthnum)
		#and the secondquartet into four values
		@quartet2split = split(/\|/,$quartet2);
		#splits that into the four sections
		@list2firstsecond = split(/\,/,$quartet2split[0]);
		@list2thirdfourth = split(/\,/,$quartet2split[1]);
		#if we found the quartet we're looking for
		if (($list2firstsecond[0] eq $orig2firstsecond[0])&&($list2firstsecond[1] eq $orig2firstsecond[1])&&
			($list2thirdfourth[0] eq $orig2thirdfourth[0])&&($list2thirdfourth[1] eq $orig2thirdfourth[1])){
			$found_key = 1;
			$thirdtotal = $value2;
		}
		#sees if the quartet is less than or greater than the one we're looking for
		elsif ($orig2firstsecond[0] lt $list2firstsecond[0]){
			$high = $mid-1;
		}
		elsif ($list2firstsecond[0] lt $orig2firstsecond[0]){
			$low = $mid+1;
		}
		elsif ($orig2firstsecond[1] lt $list2firstsecond[1]){
			$high = $mid-1;
		}
		elsif ($list2firstsecond[1] lt $orig2firstsecond[1]){
			$low = $mid+1;
		}
		elsif ($orig2thirdfourth[0] lt $list2thirdfourth[0]){
			$high = $mid-1;
		}
		elsif ($list2thirdfourth[0] lt $orig2thirdfourth[0]){
			$low = $mid+1;
		}
		elsif ($orig2thirdfourth[1] lt $list2thirdfourth[1]){
			$high = $mid-1;
		}
		else{
			$low = $mid+1;
		}
	}

	#adds the three totals together
	my ($quartet3, $firsttotal) = split(/\:/,$line);
	my $total = $firsttotal + $secondtotal + $thirdtotal;
	print $out "$line:$total\n";
	
}
close $in;
close $out;
