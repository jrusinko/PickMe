#!/bin/sh

# it requires 64 bit machine
# usage inputfile outputfile
tmp=`mktemp`
#cat $1| xargs -I@ sh -c 'echo -n "@" >'$tmp'; /projects/sate7/tools/bin/triplets.soda2103 fancy printQuartets '$tmp';'
#cat $1| xargs -I@ sh -c 'echo -n "@" >'$tmp'; /projects/sate7/tools/bin/triplets.soda2103 printQuartets '$tmp';'|sed 's/.*: //'| python /u/bayzid/Research/simulation_study/tools/run_scripts/summarize.triplets.py


#cat $1| xargs -I@ sh -c 'echo -n "@" >'$tmp'; /projects/sate7/tools/bin/triplets.soda2103 printQuartets '$tmp';'|sed 's/.*: //' > $2

#cat $1| xargs -I@ sh -c 'echo -n "@" >'$tmp'; /projects/sate7/tools/bin/triplets.soda2103 printQuartets '$tmp';'|sed 's/.*: //' 

#cat $1| xargs -I@ sh -c 'echo -n "@" >'$tmp'; ./triplets.soda2103 printQuartets '$tmp';'|sed 's/.*: //'| sed 's/^/\(\(/'| sed 's/$/\)\)\;/'| sed 's/ | /\),\(/'| sed 's/ /\,/g

#for x in `cat $1`; do echo $x|tr -d '\n' > $tmp; ./triplets.soda2103 printQuartets $tmp; done|sed 's/.*: //'| sed 's/^/\(\(/'| sed 's/$/\)\)\;/'| sed 's/ | /\),\(/'| sed 's/ /\,/g' # '

for x in `cat $1`; do echo $x|tr -d '\n' > $tmp; ./triplets.soda2103 printQuartets $tmp; done|sed 's/.*: //'| sed 's/^/\(\(/'| sed 's/$/\)\)\;/'| sed 's/ | /\),\(/'| sed 's/ /\,/g' # '
