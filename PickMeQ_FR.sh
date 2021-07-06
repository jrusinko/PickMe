#!/bin/bash
INPUTFILE=${1?Error: no inputfile provided}
QUARTETS=${3-$1_quartets}
QSTYLE=${2-A}
RUNINFO=${4-$1_runinfo}
# get rid of windos EOL errors
tr -d '\15\34' < $INPUTFILE > temp
mv -f temp $INPUTFILE

# remove trees with negative branchlengths
grep :- $INPUTFILE > negbranch
grep -v :- $INPUTFILE > temp
mv temp $INPUTFILE

# remove trees with NaN
grep :N $INPUTFILE >> negbranch
grep -v :- $INPUTFILE > temp
mv temp $INPUTFILE

start=$(date +%s.%N)
echo "Thank you for using PickMeQ Version 1.0" > header
echo "This output was generated using the genetrees in the file " $INPUTFILE >> header
echo "on " >> header
date >> header

echo grouping quartets
./quartet-controller.sh $INPUTFILE quartets
echo finding total quartets
perl total_quartets2.pl quartets totalquartets

if [ $QSTYLE == A ] 
   then
	echo finding weights
	java FormulaVersion624 totalquartets $QUARTETS
	echo "The file " $QUARTETS " may be used as input for ASTRAL. See https://github.com/smirarab/ASTRAL/blob/master/astral-tutorial.md  for the latest version." > filenote
	
   else
	echo finding weights
	perl change_name.pl totalquartets naming totalquartetsnamed
	cp naming naming-$INTPUTFILE
	java FormulaVersion624 totalquartetsnamed $QUARTETS
	echo "The file " $QUARTETS " may be used as input for Weighted Quartets Maxcut. See http://research.haifa.ac.il/~ssagi/software/wQMC.tar.gz  for the latest version." > filenote
	echo "At this time weighted quartets maxcut requires taxa to be labeled as integers. The indicated file has this propoerty.  Once you have run weigthed quartets maxcut you can replace with the original taxa using our code: perl reverse_name.pl OUTPUTFROMMAXCUT " naming-$INTPUTFILE " PREFEREDNAMEOFOOUTPUT " >> filenote.  
fi


duration=$(echo "$(date +%s.%N) - $start" | bc)
LC_NUMERIC="C"
execution_time=`printf "%.2f seconds" $duration`

echo "All gene submitted gene trees were used to conduct the analysis." > nlength
echo "" >> nlength
if test -s negbranch; then
	rm nlength
	echo "The following gene trees were not used because they included negative branch lengths or non numerical branch lengths:" > nlength
	echo "" >> nlength
	cat negbranch >> nlength
	echo "" >> nlength
fi
echo "Script Execution Time: $execution_time"  > footnote
echo "" >> footnote
echo "When using this software please site OUR PAPER REF:" >> footnote
echo "" >> footnote
echo "As well as the Ruth Davidson, Pranjal Vachaspati, Siavash Mirarab, and Tandy Warnow.  Phylogenomic species tree estimation in the presence of incomplete lineage sorting and horizontal gene-transfer .BMC genomics, 16(10):S1, 2015. whose software is used in the computation of quartest. Please also cite  Jens Johansen, Morten Kragelund Holt, et al.  Computing triplet and quartet distances.from which the quartet computation algorithem is the bases for the quartet-software " >> footnote


cat header nlength footnote filenote > $RUNINFO


rm -f quartets

rm -f totalquartetsnamed
rm -f weightedquartets
rm -f numbertree
rm -f naming
rm -f footnote
rm -f header
rm -f nlength
rm -f negbranch
rm -f totalquartets
rm -f filenote
