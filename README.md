1. **Materials**

**1.1 System requirements and installation**

PickMe and PickMeQ requires PERL, JAVA, as well as BASH command lines. These programs can be easily run from UNIX system (Command lines are in bold).  PickMe can and PickMeQ can also be run on Windows 10 through the Windows Subsystem for Linux (see https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6?activetab=pivot:overviewtab) for one such example.  Once WSL is loaded the same instructions below apply.

Please cite XXX when you use this software.

Ubuntu system requires JAVA, that can be installed following these command lines:

**java -version**

**sudo apt update**

**sudo apt install default-jre**

**sudo apt install default-idk**

**java -version**

OpenSUSE system requires bc, that can be installed following this command line:

**zipper in bc**

To use PickMe and PickMeQ on Unix system, it is necessary to assign access rights to user using these command lines (if the PickMe-main folder was moved, users must indicate the full path):

**cd PickMe-main/**

**sudo chmod +rwx \***

If the PickMe-main folder was moved to the Desktop:

**cd Desktop/PickMe-main/**

**sudo chmod +rwx \***

**1.2 PickMe Shortcut**

There are two possibilities to use PickMe tools, (1) move to PickMe-main folder and running the tools (see Methods 2.1) or (2) from a shortcut installed anywhere (see Methods 2.2). The following explanations allow the installation of the shortcut.

Move the PickMe-main folder in the favorite folder.

Check dependencies.

Move PickMe-shortcut.sh in the Desktop (or in the favorite folder).

Open PickMe-shortcut.sh with a text editor.

Change the line 3, please indicate the full path of the PickMe-main folder.

Command lines example:

After downloaded PickMe-main from GitHub, it was moved to Desktop/MyResearch/Tools. The user wants to use PickMe tools from the Desktop.

Running command lines section 1.1, then:

**cd Desktop/MyResearch/Tools/**

**cp PickMe-shortcut.sh /home/[user]/Desktop/**

**cd /home/[user]/Desktop/**

**sudo chmod +rwx PickMe-shortcut.sh**

Line 3 of PickMe-shortcut.sh: **PATH=&quot;/home/julien/Bureau/JOE/PickMe-main&quot;** replaced by: **PATH=&quot;/home/julien/Desktop/MyResearch/Tools/PickMe-main**&quot; with julien=[user].

**1.3 PickMeQ options**

PickMeQ userers may choose the type of output file (option A to generate Astral input file; option M to generate Quartet Maxcut input file, see Methods section).

**1.4 Input files requirements**

PickMe and PickMeQ require a .txt file including all phylogenetic trees generated by phylogenomic tools (e.g. RAxML, IQ-TREE). All the trees files must have the same samples names (e.g. Sample\_Potato). The .txt file can be cleaned using CTN.py (available at https://github.com/juboutte?tab=repositories).

1. **Methods**

Command lines are in bold. Outputfiles are generated in the input file folder.

**2.1 Running PickMe from the man folder**

**2.1.1 PickMe**

Input files:

A TXT file (PickMe-main/sampletrees.txt)

Output files:

sampletrees.txt\_graph (sample reliability score and gene occupancy rate for each sample)

sampletrees.txt\_output (containing list of all samples categorized based on their support for inclusion in phylogenomic analyses)

**cd Desktop/PickMe-main**

**./PickMe.sh sampletrees.txt**

**2.1.2 PickMeQ (Astral output)**

Input files:

A TXT file (PickMe-main/sampletrees.txt)

Output files:

sampletrees.txt\_runinfo (containing information such as references and script execution time)

sampletrees.txt\_quartets (Astral input file)

**cd Desktop/PickMe-main**

**./PickMeQ.sh sampletrees.txt A**

**2.1.3 PickMeQ (Quartet Maxcut output)**

Input files:

A TXT file (PickMe-main/sampletrees.txt)

Output files:

sampletrees.txt\_runinfo (containing several information such as references and script execution time)

sampletrees.txt\_quartets (Quartet Maxcut input file)

**cd Desktop/PickMe-main**

**./PickMeQ.sh sampletrees.txt M**

**2.2 Running PickMe from the shortcut**

**2.2.1 PickMe**

Input files:

A TXT file (Desktop/MyResearch/Tools/PickMe-main/sampletrees.txt)

Output files:

sampletrees.txt\_graph  (sample reliability score and gene occupancy rate for each sample)

sampletrees.txt\_output (containing list of all samples categorized based on their support for inclusion in phylogenomic analyses)

**cd Desktop/**

**./PickMe-shortcut.sh PickMe.sh Desktop/MyResearch/Tools/PickMe-main/sampletrees.txt**

**2.1.2 PickMeQ (Astral output)**

Input files:

A TXT file (Desktop/MyResearch/Tools/PickMe-main/sampletrees.txt)

Output files:

sampletrees.txt\_runinfo (containing several information such as references and script execution time)

sampletrees.txt\_quartets (Astral input file)

**cd Desktop/**

**./PickMe-shortcut.sh PickMeQ.sh Desktop/MyResearch/Tools/PickMe-main/sampletrees.txt A**

**2.1.3 PickMeQ (Quartet Maxcut output)**

Input files:

A TXT file (Desktop/MyResearch/Tools/PickMe-main/sampletrees.txt)

Output files:

sampletrees.txt\_runinfo (containing several information such as references and script execution time)

sampletrees.txt\_quartets (Quartet Maxcut input file)

**cd Desktop/**

**./PickMe-shortcut.sh PickMeQ.sh Desktop/MyResearch/Tools/PickMe-main/sampletrees.txt M**

1. **Troubleshooting Guide**

  1. **Decimal separator issues:**

PickMe.sh error line 129-132: please use PickeMe\_FR.sh (comma separator)

PickMeQ.sh error line 46-49: please use PickeMeQ\_FR.sh (comma separator)

**3.2 Permission denied issues:**

Assign access rights to user using these command lines (if the PickMe-main folder was moved, users must indicate the full path):

**cd PickMe-main/**

**sudo chmod +rwx \***

If the PickMe-main folder was moved to the Desktop:

**cd Desktop/PickMe-main/**

**sudo chmod +rwx \***

Assign access rights to user for the shortcut file:

**cd Desktop/**

**sudo chmod +rwx PickMe-shortcut.sh**

  1. **Folder not found using shortcut file**

Please check the full path, line 3 of the PickMe-shortcut.sh file. If you moved PickMe-main, you need to change the full path.


