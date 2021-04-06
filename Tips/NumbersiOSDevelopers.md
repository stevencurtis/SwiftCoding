# Numbers every iOS developer should know

Pareto's principle
The 80:20 rule

8 bits = 1 byte
1000 bytes = 1k
1000 k = 1MB
1000MB = 1GB
1000GB = 1TB

1 million users 
with 1k = 1 GB
with 1MB =  1 TB
with 1GB =  1 PB

with 5MBs 5Tb/s since 1 million & 5M b/S

12 requests per second is 1 million a day
4 requests per second is 300,000 a day or 10 million a month
https://lazycpm.com/qps-calculator/

ios 14(2020+) - to 6S
ios 13 (2019+) - to 6S
iOS 12 (2018+) - to 5S 
iOS 11 (2017+) - to 5S 

Writes are more expensive than reads
Architect for scaling writes

Image sizes

Common media files    Average download time (s=seconds, m=minutes, h=hours)
File type    Estimated file size    .5 Mbps    3 Mbps    6 Mbps    10 Mbps    18 Mbps    25 Mbps    35 Mbps    50 Mbps    
Webpage          1 MB                  16 s          3 s           1 s            < 1 s          < 1 s           < 1 s         < 1 s          < 1 s    
E-book              3 MB                  48 s         8 s           4 s            2.5 s           1.5 s           1 s            < 1 s          < 1 s    
mp3 song          5 MB                  80 s         13 s         7 s            4 s              2 s              1.5 s         1 s             < 1 s    
5 minute video  20 MB                5 m          53 s         27 s          16 s            9 s              6.5 s         5 s             3 s    
1 hr TV show     1 GB                  4.5 h        44 m        22 m        14 m           7.5 m          5 m           4.5 m        2.5 m    
SD movie           2 GB                  9 h           88 m       44 m         27 m          15 m           11 m          9 m           5 m    
1080p movie     12 GB                53 h          9 h          4.5 h         2.5 h          1.5 h           1 h            46 m          32 m    



Availability %    Downtime per year   Downtime per month*
98%                  7.30 days                  14.4 hours
99%                  3.65 days                  7.20 hours
99.5%               1.83 days                  3.60 hours
99.8%               17.52 hours               86.23 minutes


Power           Exact Value         Approx Value        Bytes
---------------------------------------------------------------
7                         128
8                         256
10                       1024                              1 thousand                           1 KB
16                       65,536                           64 KB
20                       1,048,576                      1 million                               1 MB
30                       1,073,741,824               1 billion                                1 GB
32                       4,294,967,296               4 GB
40                       1,099,511,627,776        1 trillion                                1 TB



Traffic
Read request per sec, write requests per sec)

Bandwith estimate
number of bytes/second

Storage
* A web page 2MB so 100M webpages so 200000GB  so 200 tb
How much to store?

* Engineering effort 

* Money

* CPU time

* RAM size

* Thread count



Potential Problem Areas and Fixes

https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/PerformanceTips/PerformanceTips.html

Look for these possible problem areas:

Code that’s reading lots of files (of any type) from disk. Remember to look for places where you are loading resource files too. Are you actually using the data from all of those files right away? If not, you might want to load some of the files more lazily.
Code that uses older file-system calls. Most calls should be using Swift or Objective-C APIs. You can use BSD-level calls too, but don’t use older Carbon-based functions that operate on FSRef or FSSpec data structures. Xcode generates warnings when it detects your code using deprecated methods and functions, so make sure you check those warnings. Also see Use Modern File System Interfaces.
Code that uses callback functions or methods to process file data. If a newer API is available that takes a block object, update your code to use that API instead.
Code with many small read or write operations performed on the same file. Can you group those operations together and perform them all at once? For the same amount of data, one large read or write operation is usually more efficient than many small operations.

