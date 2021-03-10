#!/bin/bash
INPUTFILE=${1?Error: no inputfile provided}
OUTPUTFILE=${2-$1_output}
GRAPHFILE=${3-$1_graph}

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
echo "Thank you for using PickMe Version 1.0" \n/ > header
echo "" >> header
echo "This output was generated using the genetrees in the file " $INPUTFILE "on " $start >> header
echo "" >> header




#passes the gene trees into the program quartet-controller
#the results will be written into treestotalquartets
echo grouping quartets
./quartet-controller.sh $INPUTFILE quartets
#echo finding total quartets
perl total_quartets2.pl quartets totalquartets
#perl change_name.pl totalquartets naming totalquartetsnamed

#finds weights
echo finding weights
java FormulaVersion624 totalquartets weightedquartets
#perl values.pl weightedquartets values
#java Totals values totals
java IndAvgtest weightedquartets averagesm1

rm quartets
rm totalquartets
#rm totalquartetsnamed
#rm totals
#rm values

echo selecting taxa

i=0
j=0

#ignores taxa if the average is lower than threshold
while [ $i -le 39 ]
do
    if [ $i == 0 ]
    then

	java BadTaxa averagesm1 rbtaxa $i 
	java IgnoreTaxa weightedquartets rbtaxa weightedquartets$i
	java IndAvgtest weightedquartets$i averages$i

	i=1
    else
	j=$(head -n 1 "oldlevel.txt")
	i=$(head -n 1 "nextlevel.txt")
	java BadTaxa averages$j badtaxatemp$i $i 
	if [ $i -eq 40 ]
	then
	   cat badtaxatemp$i >> exctaxa
	else
	java IgnoreTaxa weightedquartets$j badtaxatemp$i weightedquartets$i
	java IndAvgtest weightedquartets$i averages$i
	rm averages$j
	rm weightedquartets$j
	if [ $i -le 9 ]
        then  
	   cat badtaxatemp$i >> rbtaxa
	elif [ $i -le 19 ]
        then  
	   cat badtaxatemp$i >> btaxa
	elif [ $i -le 29 ]
        then  
	   cat badtaxatemp$i >> gtaxa
	elif [ $i -le 39 ]
        then  
	   cat badtaxatemp$i >> grtaxa
	fi
	rm badtaxatemp$i	
	fi
    fi
done


touch taxaresults

if test -f rbtaxa; then
	sed -i '1 s/^/These taxa are very bad (BF<3). Do not include in any analysis.\n/' rbtaxa
	cat rbtaxa >> taxaresults
	rm -f rbtaxa
fi
if test -f btaxa; then
	sed -i '1 s/^/These taxa are bad (3<BF<10). Not recommended for inclusion in analysis.\n/' btaxa
	cat btaxa >> taxaresults
	rm -f btaxa
fi
if test -f gtaxa; then
sed -i '1 s/^/These taxa are good (10<BF<30). Recommended for inclusion in analysis.\n/' gtaxa
	cat gtaxa >> taxaresults
	rm -f gtaxa
fi

if test -f grtaxa; then
	sed -i '1 s/^/These taxa are very good (30<BF<100). Strongly recommended for inclusion in analysis. \n/' grtaxa
	cat grtaxa >> taxaresults
	rm -f grtaxa
fi
if test -f exctaxa; then
	sed -i '1 s/^/These taxa are exceptionally well supported (BF>100). Include in analysis.\n/' exctaxa
	cat exctaxa >> taxaresults
	rm -f exctaxa
fi


java Coverage $INPUTFILE weightlist $GRAPHFILE
sed -i '1 s/^/Taxa:Weight:Coverage\n/' $GRAPHFILE

duration=$(echo "$(date +%s.%N) - $start" | bc)
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
echo "As well as the Ruth Davidson, Pranjal Vachaspati, Siavash Mirarab, and Tandy Warnow.  Phylogenomic species tree estimation in the presence of incomplete lineage sorting and horizontal gene-transfer .BMC genomics, 16(10):S1, 2015. whose software is used in the computation of quartest. Please also cite  Jens Johansen, Morten Kragelund Holt, et al.  Computing triplet and quartet distances.4212013 from which the quartet computation algorithem is the bases for the quartet-software " >> footnote


cat header taxaresults nlength footnote> $OUTPUTFILE 


rm -f taxaresults

rm oldlevel.txt
rm nextlevel.txt

rm -f weightlist
rm header
rm footnote
rm -f nlength
rm -f negbranch
rm averages*
rm badtaxatemp*
rm weightedquartets*

