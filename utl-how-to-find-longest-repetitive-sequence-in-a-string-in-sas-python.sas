How to find longest repetitive sequence in a string in SAS Python

  Method

     1. Create macro string to pass to Python
        %let bigStr=worldprogrammingsasinstituteoracleteradataworldprogramming;

     2. Call Python module with string
        longestRepetitiveSubstring('&bigStr');

     3. Write logest repeating sequence ie 'world programming' to windows clipboard
        Call SAS to read clipboard and save result in SAS macro variable 'frompy'

github
https://tinyurl.com/y2ptxzla
https://github.com/rogerjdeangelis/utl-how-to-find-longest-repetitive-sequence-in-a-string-in-sas-python

https://www.tutorialspoint.com/How-to-find-longest-repetitive-sequence-in-a-string-in-Python

Rajendra Dharmkar
https://www.tutorialspoint.com/profile/Rajendra-Dharmkar

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

%let bigStr=worldprogrammingsasinstituteoracleteradataworldprogramming;

%put &=bigstr;

BIGSTR = worldprogrammingsasinstituteoracleteradataworldprogramming

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

%put &=frompy;

FROMPY = worldprogramming

*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;

%let bigStr=worldprogrammingsasinstituteoracleteradataworldprogramming;

%put &=bigstr;

%utl_submit_py64("
import pyperclip;
from collections import defaultdict;
def getsubs(loc, s):;
.   substr = s[loc:];
.   i = -1;
.   while(substr):;
.       yield substr;
.       substr = s[loc:i];
.       i -= 1;
def longestRepetitiveSubstring(r):;
.   occ = defaultdict(int);
.   for i in range(len(r)):;
.       for sub in getsubs(i,r):;
.           occ[sub] += 1;
.   filtered = [k for k,v in occ.items() if v >= 2];
.   if filtered:;
.       maxkey =  max(filtered, key=len);
.       return maxkey;
.   else:;
.       raise ValueError('no repetitions of any substring of with 2 or more occurrences' % (r));

txt=longestRepetitiveSubstring('&bigStr');
print(txt);
pyperclip.copy(txt);
",return=frompy);

%put &=frompy;

FROMPY = worldprogramming

