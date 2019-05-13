# utl-how-to-find-longest-repetitive-sequence-in-a-string-in-sas-python
How to find longest repetitive sequence in a string in SAS Python How to find longest repetitive sequence in a string in SAS Python

  Two Solutions

    I. Elegant and simple application of a HASH (a natural for the HASH)
       by Paul Dorfman  sashole@bellsouth.net


   II. SAS integration with a Python function

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

*********************************************
I. Elegant and simple applivation of a HASH *
*********************************************


Roger,MP

A very nice demo on how to tap into Python for a function SAS doesn't seem to have already canned.

However, even though the LRS (Longest Repeated Substring) function is not yet canned,
it's simple to can via FCMP. Furthermore, the availability of the hash object, which allows to
insert items in a sorted order at O(1) time, makes it easy to implement LRS running in O(N) time
(where N is the length of the string).

The naive approach of comparing every substring with every other substring would obviously
run in O(N**2) time, so it won't scale. The usual method of avoiding this is to create a
prefix array, sort it, and then compare N adjacent prefixes. The need to sort results in
O(N*log(N)) run time - obviously much better than the quadratic time. To improve on that
and avoid the sort, the us
ual approach is to build a prefix tree, which is quite involved, to say at least. But with
SAS, we don't have to because it's already available in the form of the hash object,
making coding LRS a simple in-and-out procedure:

%let s = worldprogrammingsasinstituteworldprogrammingoracleteradataworldprogramming ;

proc fcmp outlib=work.f.f ;
function LRS (s $) $ ;
  declare hash h (ordered:"a") ;
  rc = h.definekey ("hs") ;
  rc = h.definedone () ;
  declare hiter i ("h") ;
  do q = 1 to length (s) ;
    hs = substr (s, q) ;
    rc = h.add() ;
  end ;
  z = s ;
  do while (i.next() = 0) ;
    q = compare (hs, z) ;
    if q > qm then do ;
      qm = q ;
      sm = z ;
    end ;
    z = hs ;
  end ;
  return (sm) ;
endsub ;
quit ;

option cmplib=work.f ;

%put lrs = %sysfunc (LRS (&s)) ;

Paul


*******************************************
II. SAS integration with Python function  *
*******************************************

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

