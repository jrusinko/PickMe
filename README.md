# PickMe
 
 PickMe is the shell script that reads in gene trees and creates the output file which lists which taxa can be included in the data.  THere are a couple of options but it should run with ./PickMe.sh sampletrees.txt 
 
 PickMeQ is the file that outputs the weighted quartets for use in Astral or Quartets Maxcut.  Since Quartet's MaxCut only allows numbers there are two options.
 ./PickMeQ.sh sampletrees.txt A
 ./PickMeQ.sh sampletrees.txt M
 
 (the output file for the maxcut version includes code to change the trees with numbers back to trees with taxa labels.
 
 Challenges:  while this runs if all of these files are in the same folder (including the dataset) I'm not sure how to install at the root, or somewhere where you can run the commands from anywhere.
 
 The maxcut program probably doesn't belong on this github (but I don't think we need it here, other than as a reference.  It is not used in the code.  However the quartet controller files aren't our code, but ARE used to compute the number of quartets.  THe output file for both programs lists a reference for citing that software. It is freely available on the author's website, so it is "proboably" better simply to link to those files.  The challene is they are embedded in a couple of folders, so when i download the folders, I then have to copy those particular files into the main folder (again a referencing issue).
 
 I did a decent amount of debugging so I'm pretty sure both programs work fairly smoothly.  It seems like the things we still need from our end would be
 a) a nicer version than this Read Me :-) 
 b) an easier way to install/run which addresses the problem of not needing to have all the files in the same directory or goinging into the code to change paths (on the user end).
 c)  Figuring out the most appropriate way to get people to access and cite this other software, while keeping the installation simple.
 d) anything else you think we need to make this "professional".
