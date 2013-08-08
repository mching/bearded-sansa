MOOC: R Exercise 1
=========

### Get the Data

First we download the data from the website.

```r
download.file(url = "https://s3-us-west-1.amazonaws.com/prod-edx/MedStats/RegressionExerciseDocs/mock_class_data.csv", 
    destfile = "week1R.csv", method = "curl")
```


Then we have to read the csv into R.

```r
data <- read.csv("./week1R.csv")
```


### First look...
We can look at the data names and types.

```r
str(data)
```

```
## 'data.frame':	56 obs. of  26 variables:
##  $ ID         : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ coffee     : int  16 0 2 0 2 12 16 4 12 4 ...
##  $ Varsity    : int  0 1 1 1 0 1 1 1 1 0 ...
##  $ Milk       : int  6 0 0 0 0 0 6 2 1 4 ...
##  $ exercise   : num  2 0 3 3 2 3 2.5 10 3.5 3.5 ...
##  $ wakeup     : num  7.5 9.5 7 7.5 9 7.5 7.5 6.5 7.5 9 ...
##  $ politics   : int  38 60 95 80 72 70 80 75 80 85 ...
##  $ fruitveg   : int  4 3 7 3 10 6 3 8 1 4 ...
##  $ obama      : int  40 72 85 80 65 80 80 80 80 65 ...
##  $ bushjr     : int  70 24 0 8 18 20 20 0 5 10 ...
##  $ clinton    : int  70 76 92 86 72 75 80 NA 90 80 ...
##  $ bushsr     : int  50 19 10 NA 37 30 40 75 20 NA ...
##  $ regan      : int  70 64 20 25 39 35 45 20 21 25 ...
##  $ carter     : int  49 62 40 51 48 60 50 60 65 NA ...
##  $ Mathlove   : int  25 50 65 85 43 10 65 65 20 35 ...
##  $ WritingLove: int  65 48 10 50 51 51 70 80 70 10 ...
##  $ optimism   : int  70 78 90 75 62 75 75 20 90 70 ...
##  $ alcohol    : int  1 3 1 1 1 3 2 3 7 0 ...
##  $ sleep      : num  7 7 7 6.5 7.5 7 6 6.5 7 6 ...
##  $ IsBookSmart: int  1 1 1 1 1 1 1 1 1 1 ...
##  $ homework   : int  15 20 40 0 7 10 25 1 0 20 ...
##  $ healthcare : int  35 68 70 65 61 60 85 100 90 75 ...
##  $ X          : logi  NA NA NA NA NA NA ...
##  $ X.1        : logi  NA NA NA NA NA NA ...
##  $ X.2        : logi  NA NA NA NA NA NA ...
##  $ X.3        : logi  NA NA NA NA NA NA ...
```

It's not apparent why yet, but the last 4 variables (columns) are all logical variables and all of their values are NA...

```r
summary(data[23:26])
```

```
##     X             X.1            X.2            X.3         
##  Mode:logical   Mode:logical   Mode:logical   Mode:logical  
##  NA's:56        NA's:56        NA's:56        NA's:56
```


Also the last 6 rows are all NAs as well.

```r
data[51:56, ]
```

```
##    ID coffee Varsity Milk exercise wakeup politics fruitveg obama bushjr
## 51 NA     NA      NA   NA       NA     NA       NA       NA    NA     NA
## 52 NA     NA      NA   NA       NA     NA       NA       NA    NA     NA
## 53 NA     NA      NA   NA       NA     NA       NA       NA    NA     NA
## 54 NA     NA      NA   NA       NA     NA       NA       NA    NA     NA
## 55 NA     NA      NA   NA       NA     NA       NA       NA    NA     NA
## 56 NA     NA      NA   NA       NA     NA       NA       NA    NA     NA
##    clinton bushsr regan carter Mathlove WritingLove optimism alcohol sleep
## 51      NA     NA    NA     NA       NA          NA       NA      NA    NA
## 52      NA     NA    NA     NA       NA          NA       NA      NA    NA
## 53      NA     NA    NA     NA       NA          NA       NA      NA    NA
## 54      NA     NA    NA     NA       NA          NA       NA      NA    NA
## 55      NA     NA    NA     NA       NA          NA       NA      NA    NA
## 56      NA     NA    NA     NA       NA          NA       NA      NA    NA
##    IsBookSmart homework healthcare  X X.1 X.2 X.3
## 51          NA       NA         NA NA  NA  NA  NA
## 52          NA       NA         NA NA  NA  NA  NA
## 53          NA       NA         NA NA  NA  NA  NA
## 54          NA       NA         NA NA  NA  NA  NA
## 55          NA       NA         NA NA  NA  NA  NA
## 56          NA       NA         NA NA  NA  NA  NA
```



### 1. ‘Varsity’ is currently stored as type ‘double’. Change this continuous variable to a categorical variable. R denotes categorical variables as factors. 

```r
data$Varsity <- factor(data$Varsity)
```


### 2. Sort data, first in ascending order by ‘Varsity’, then in decreasing order by ‘WritingLove’.


```r
data.sorted <- data[order(data$Varsity, -data$WritingLove), ]
data.sorted
```

```
##    ID coffee Varsity Milk exercise wakeup politics fruitveg obama bushjr
## 39 39     12       0   16      5.0    7.5       93        2    99     19
## 29 29     20       0    0      2.0    5.5       39        3    32     29
## 13 13     32       0    4      4.5    6.0       84        5   100     11
## 16 16      3       0    6      2.5    6.5       75        5    95      0
## 32 32      0       0   16      8.0    7.0       82        1    90      0
## 40 40     12       0    0      4.5    8.0       92        3    90     20
## 34 34     16       0    8      0.0   11.0       88        4    89     32
## 1   1     16       0    6      2.0    7.5       38        4    40     70
## 17 17      8       0    0      3.0    7.0       50        3    70     45
## 22 22      2       0    8      2.0    7.0       66        3    80      7
## 46 46      8       0    3     10.0    8.0       42        1    50     50
## 5   5      2       0    0      2.0    9.0       72       10    65     18
## 49 49     32       0    8      7.0    7.5       85        4    90     22
## 43 43      6       0    6      0.5    9.0       71        3    75     30
## 19 19     40       0    4      3.0    6.0       80        6    80     20
## 35 35     32       0    4      3.0    8.0       81        6    91     20
## 45 45      0       0    0      5.5    8.0       79        1    92     60
## 10 10      4       0    4      3.5    9.0       85        4    65     10
## 11 11      0       0   12      1.0    7.5       NA        2    72     24
## 31 31     12       0    6      2.5    7.0       99        1   100     10
## 30 30      2       1   50      7.0    5.0       27        5    59     96
## 42 42      0       1    2      2.5    7.0       72        6    89      0
## 48 48      0       1   12      2.0    8.5       44        1    61      6
## 8   8      4       1    2     10.0    6.5       75        8    80      0
## 33 33     12       1    0      3.0    9.0       72        5    82     22
## 38 38      0       1   NA     10.0    5.5       91        6    90     20
## 47 47      0       1    3      8.0    7.0       85        5    60     33
## 7   7     16       1    6      2.5    7.5       80        3    80     20
## 9   9     12       1    1      3.5    7.5       80        1    80      5
## 25 25     10       1    3      4.5    6.0       85        4    80     10
## 50 50     40       1    0      5.0    8.0       70        3    80     30
## 21 21      4       1    4      0.5    7.5       75        2    75     10
## 20 20     16       1    0      6.0    6.5       71        4    74     32
## 12 12      6       1    6      7.0    8.5       80        3    78     15
## 24 24     16       1   10      6.0    7.5       NA        2    NA     NA
## 23 23      0       1   16      7.0    7.5       65        1    71      0
## 27 27     12       1    5      2.0    7.5       64        4    66     37
## 18 18      8       1    4      4.0    7.0       80        3    90      2
## 6   6     12       1    0      3.0    7.5       70        6    80     20
## 4   4      0       1    0      3.0    7.5       80        3    80      8
## 2   2      0       1    0      0.0    9.5       60        3    72     24
## 14 14     16       1    4      5.0    6.5       80        3    75     30
## 36 36      0       1    0      2.0    8.0       89        7    95      8
## 44 44      0       1    0      6.0    9.5       39        4    55     61
## 26 26     16       1    6      3.0    7.5       78        2    82      0
## 41 41     12       1    0      4.0    7.0      100        5    80      9
## 15 15     12       1    8      4.0    6.0       75        4    88     16
## 3   3      2       1    0      3.0    7.0       95        7    85      0
## 37 37      8       1    0      1.0    8.0       93        6    85     21
## 28 28     12       1   12     12.0    7.0       67        4    71     14
## 51 NA     NA    <NA>   NA       NA     NA       NA       NA    NA     NA
## 52 NA     NA    <NA>   NA       NA     NA       NA       NA    NA     NA
## 53 NA     NA    <NA>   NA       NA     NA       NA       NA    NA     NA
## 54 NA     NA    <NA>   NA       NA     NA       NA       NA    NA     NA
## 55 NA     NA    <NA>   NA       NA     NA       NA       NA    NA     NA
## 56 NA     NA    <NA>   NA       NA     NA       NA       NA    NA     NA
##    clinton bushsr regan carter Mathlove WritingLove optimism alcohol sleep
## 39     100     44    37     54       67          95       51       0   7.0
## 29      61     39    76     47       81          82       87       1   7.0
## 13      69     28    38     60       60          72       51       3   5.0
## 16      NA     15    50     51       70          70      100       2   7.0
## 32      86     15    45     80       65          70       90       0   6.0
## 40      85     46    53     47       70          70       90       5   6.5
## 34      92     25    51     23       92          66       67       6   6.5
## 1       70     50    70     49       25          65       70       1   7.0
## 17      70     49    49     51       40          55       75       8   6.5
## 22      88     37    44     NA       44          55       70       4   6.5
## 46      56     52    49     48       69          54       76       2   8.0
## 5       72     37    39     48       43          51       62       1   7.5
## 49      98     33    20     49       20          29       75       0   6.0
## 43      33     49    50     50       80          24       80       3   8.0
## 19      80     35    35     50       80          20       90       2   7.0
## 35      80     50    60     78       75          20       89       0   6.5
## 45      65     67    80     80       54          19       75       0   7.5
## 10      80     NA    25     NA       35          10       70       0   6.0
## 11      NA     NA    NA     NA       23          NA       82       0   7.0
## 31      80     10     5     80       43          NA      100       0   8.0
## 30      92     90    11     12       98          98       97       0   8.0
## 42      81     30    55     52       70          91       82       3   7.0
## 48     100     30    25     22       49          83       40       3   6.5
## 8       NA     75    20     60       65          80       20       3   6.5
## 33      72     32    39     44       80          80       91       2   7.5
## 38      78     NA    NA     NA       59          80      100       2   7.0
## 47      50     19    50     50       78          73       99       1   6.0
## 7       80     40    45     50       65          70       75       2   6.0
## 9       90     20    21     65       20          70       90       7   7.0
## 25      90     20    25     90       60          70       85       2   7.0
## 50      75     50    50     50       88          70       80       5   6.0
## 21      65      5     5     65       80          65       33       5   8.0
## 20      NA     NA    NA     NA       69          64      100       5   7.0
## 12      78     23    23     78       67          62       90       6   7.5
## 24      NA     NA    NA     NA       NA          62      100       1   8.0
## 23      72     57    NA     NA       49          61       44       0   8.5
## 27      61     NA    NA     NA       NA          61       40       1   8.0
## 18     100     20    10     80       60          60       40       3   7.0
## 6       75     30    35     60       10          51       75       3   7.0
## 4       86     NA    25     51       85          50       75       1   6.5
## 2       76     19    64     62       50          48       78       3   7.0
## 14      72     40    NA     NA       55          45       75       5   7.5
## 36      70      9    50     51       50          45       69       5   6.5
## 44      39     77    85     48       85          30       90       1   8.0
## 26      93      0     0     NA       90          23       NA       2   6.0
## 41      88     23     5     30       35          23       78       3   7.0
## 15      90     NA    73     NA       62          18       93       0   7.0
## 3       92     10    20     40       65          10       90       1   7.0
## 37      55     30    49     77       80           8       84       0   8.0
## 28      73     12    18     NA       NA          NA       66       1   6.0
## 51      NA     NA    NA     NA       NA          NA       NA      NA    NA
## 52      NA     NA    NA     NA       NA          NA       NA      NA    NA
## 53      NA     NA    NA     NA       NA          NA       NA      NA    NA
## 54      NA     NA    NA     NA       NA          NA       NA      NA    NA
## 55      NA     NA    NA     NA       NA          NA       NA      NA    NA
## 56      NA     NA    NA     NA       NA          NA       NA      NA    NA
##    IsBookSmart homework healthcare  X X.1 X.2 X.3
## 39           1       15         72 NA  NA  NA  NA
## 29           0        2         22 NA  NA  NA  NA
## 13           0        4         68 NA  NA  NA  NA
## 16           1        0         80 NA  NA  NA  NA
## 32           1        2         NA NA  NA  NA  NA
## 40           0       25         90 NA  NA  NA  NA
## 34           0       30         69 NA  NA  NA  NA
## 1            1       15         35 NA  NA  NA  NA
## 17           1        3         60 NA  NA  NA  NA
## 22           1       10         35 NA  NA  NA  NA
## 46           1        3         56 NA  NA  NA  NA
## 5            1        7         61 NA  NA  NA  NA
## 49           0       33         95 NA  NA  NA  NA
## 43           1       10         NA NA  NA  NA  NA
## 19           1        0         75 NA  NA  NA  NA
## 35           1       10         80 NA  NA  NA  NA
## 45           1       15         84 NA  NA  NA  NA
## 10           1       20         75 NA  NA  NA  NA
## 11           1        3         81 NA  NA  NA  NA
## 31           1       40         80 NA  NA  NA  NA
## 30           1        1         95 NA  NA  NA  NA
## 42           0       NA         63 NA  NA  NA  NA
## 48           0       10         21 NA  NA  NA  NA
## 8            1        1        100 NA  NA  NA  NA
## 33           1       21         60 NA  NA  NA  NA
## 38           1       15         75 NA  NA  NA  NA
## 47           1       20         90 NA  NA  NA  NA
## 7            1       25         85 NA  NA  NA  NA
## 9            1        0         90 NA  NA  NA  NA
## 25           1       10         75 NA  NA  NA  NA
## 50           0       20         90 NA  NA  NA  NA
## 21           1        5         90 NA  NA  NA  NA
## 20           1        4         72 NA  NA  NA  NA
## 12           1        2         76 NA  NA  NA  NA
## 24           1        5         NA NA  NA  NA  NA
## 23           0        0         63 NA  NA  NA  NA
## 27           1       15         58 NA  NA  NA  NA
## 18           1       10         65 NA  NA  NA  NA
## 6            1       10         60 NA  NA  NA  NA
## 4            1        0         65 NA  NA  NA  NA
## 2            1       20         68 NA  NA  NA  NA
## 14           1        0         60 NA  NA  NA  NA
## 36           1       20         60 NA  NA  NA  NA
## 44           1       10         76 NA  NA  NA  NA
## 26           1       10         83 NA  NA  NA  NA
## 41           1       15         35 NA  NA  NA  NA
## 15           1        3         69 NA  NA  NA  NA
## 3            1       40         70 NA  NA  NA  NA
## 37           1       20         65 NA  NA  NA  NA
## 28          NA        0         91 NA  NA  NA  NA
## 51          NA       NA         NA NA  NA  NA  NA
## 52          NA       NA         NA NA  NA  NA  NA
## 53          NA       NA         NA NA  NA  NA  NA
## 54          NA       NA         NA NA  NA  NA  NA
## 55          NA       NA         NA NA  NA  NA  NA
## 56          NA       NA         NA NA  NA  NA  NA
```



### 3. Filter the data such that you create a dataset with only records of students who have ‘MathLove’ scores greater than or equal to 70. 
First look at how many Mathlove >= 70.

```r
summary(data$Mathlove >= 70)
```

```
##    Mode   FALSE    TRUE    NA's 
## logical      30      17       9
```


There are 17 that are >= 70 with 9 NAs.  

We have to filter for >= 70.

```r
data.filter <- data[data$Mathlove >= 70, ]
```


We can further filter out those on Mathlove that are NA.


```r
data.filter <- data.filter[!is.na(data.filter$Mathlove), ]
```


### 4. Click on Extras -> Data Summary for a quick summary of all the variables in your dataset. How many missing values does the variable ‘carter’ have?

```r
summary(data)
```

```
##        ID           coffee     Varsity        Milk          exercise    
##  Min.   : 1.0   Min.   : 0.0   0   :20   Min.   : 0.00   Min.   : 0.00  
##  1st Qu.:13.2   1st Qu.: 2.0   1   :30   1st Qu.: 0.00   1st Qu.: 2.12  
##  Median :25.5   Median : 8.0   NA's: 6   Median : 4.00   Median : 3.25  
##  Mean   :25.5   Mean   :10.1             Mean   : 5.41   Mean   : 4.16  
##  3rd Qu.:37.8   3rd Qu.:15.0             3rd Qu.: 6.00   3rd Qu.: 5.88  
##  Max.   :50.0   Max.   :40.0             Max.   :50.00   Max.   :12.00  
##  NA's   :6      NA's   :6                NA's   :7       NA's   :6      
##      wakeup         politics        fruitveg         obama      
##  Min.   : 5.00   Min.   : 27.0   Min.   : 1.00   Min.   : 32.0  
##  1st Qu.: 7.00   1st Qu.: 69.2   1st Qu.: 3.00   1st Qu.: 71.0  
##  Median : 7.50   Median : 78.5   Median : 4.00   Median : 80.0  
##  Mean   : 7.45   Mean   : 73.8   Mean   : 3.82   Mean   : 77.7  
##  3rd Qu.: 8.00   3rd Qu.: 85.0   3rd Qu.: 5.00   3rd Qu.: 89.0  
##  Max.   :11.00   Max.   :100.0   Max.   :10.00   Max.   :100.0  
##  NA's   :6       NA's   :8       NA's   :6       NA's   :7      
##      bushjr        clinton          bushsr         regan        carter    
##  Min.   : 0.0   Min.   : 33.0   Min.   : 0.0   Min.   : 0   Min.   :12.0  
##  1st Qu.: 8.0   1st Qu.: 70.0   1st Qu.:20.0   1st Qu.:22   1st Qu.:48.0  
##  Median :20.0   Median : 78.0   Median :31.0   Median :39   Median :51.0  
##  Mean   :21.4   Mean   : 76.8   Mean   :34.3   Mean   :39   Mean   :54.8  
##  3rd Qu.:30.0   3rd Qu.: 88.0   3rd Qu.:48.2   3rd Qu.:50   3rd Qu.:64.2  
##  Max.   :96.0   Max.   :100.0   Max.   :90.0   Max.   :85   Max.   :90.0  
##  NA's   :7      NA's   :11      NA's   :14     NA's   :13   NA's   :18    
##     Mathlove     WritingLove      optimism        alcohol    
##  Min.   :10.0   Min.   : 8.0   Min.   : 20.0   Min.   :0.00  
##  1st Qu.:49.0   1st Qu.:37.5   1st Qu.: 70.0   1st Qu.:1.00  
##  Median :65.0   Median :61.0   Median : 78.0   Median :2.00  
##  Mean   :60.9   Mean   :54.9   Mean   : 76.1   Mean   :2.28  
##  3rd Qu.:79.0   3rd Qu.:70.0   3rd Qu.: 90.0   3rd Qu.:3.00  
##  Max.   :98.0   Max.   :98.0   Max.   :100.0   Max.   :8.00  
##  NA's   :9      NA's   :9      NA's   :7       NA's   :6     
##      sleep       IsBookSmart       homework      healthcare   
##  Min.   :5.00   Min.   :0.000   Min.   : 0.0   Min.   : 21.0  
##  1st Qu.:6.50   1st Qu.:1.000   1st Qu.: 3.0   1st Qu.: 60.5  
##  Median :7.00   Median :1.000   Median :10.0   Median : 72.0  
##  Mean   :6.97   Mean   :0.816   Mean   :11.4   Mean   : 70.0  
##  3rd Qu.:7.50   3rd Qu.:1.000   3rd Qu.:20.0   3rd Qu.: 82.0  
##  Max.   :8.50   Max.   :1.000   Max.   :40.0   Max.   :100.0  
##  NA's   :6      NA's   :7       NA's   :7      NA's   :9      
##     X             X.1            X.2            X.3         
##  Mode:logical   Mode:logical   Mode:logical   Mode:logical  
##  NA's:56        NA's:56        NA's:56        NA's:56       
##                                                             
##                                                             
##                                                             
##                                                             
## 
```

'carter' has 18 NA's. For some reason this is different than the Deducer solution in the answer key.

### 5. Create a histogram for the variable ‘coffee’ in dark blue.


```r
hist(data$coffee, col = "darkblue")
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 



### 6. Create a scatterplot of hours of exercise (‘exercise’) vs. hours of homework (‘homework’). Include a smoothed loess curve. Comment on what you see (trends, outliers, etc.). 

```r
scatter.smooth(data$exercise, data$homework, pch = 19, cex = 0.5)
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 



### 7. Create a histogram for ‘milk’. You notice that there is one person who indicated ‘50’ that seems like an outlier. After going back to the data collection forms, you verify that 50 was indeed miscoded, and that the true value is 5. You decide to fix this problem by creating a new variable called ‘milkFixed’. (Hint: Save before attempting. Go to Data  Recode Variables. Be sure to hit the “ Target” button while you have the item in “Variables to Recode” highlighted. This will allow you to rename the new variable so you do not overwrite your existing values. Specify conditions in “Define Recode”)

```r
hist(data$Milk)
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14.png) 


Copy old variable into new `milkFixed` variable.

```r
data$milkFixed <- data$Milk
```


Which individual answered 50 (or more than 20 anyway)? It is individual 30.

```r
which(data$milkFixed == 50)
```

```
## [1] 30
```


Take individual 30 and make that into a 5, not a 50.

```r
data$milkFixed[30] <- 5
```


Histogram looks much better!

```r
hist(data$milkFixed)
```

![plot of chunk unnamed-chunk-18](figure/unnamed-chunk-18.png) 


### 8. What is the mean, standard deviation, and median number of hours of sleep in the dataset?

```r
mean(data$sleep, na.rm = T)
```

```
## [1] 6.97
```

```r
sd(data$sleep, na.rm = T)
```

```
## [1] 0.7382
```

```r
median(data$sleep, na.rm = T)
```

```
## [1] 7
```

```r

mean(data.filter$sleep, na.rm = T)
```

```
## [1] 7.029
```

```r
sd(data.filter$sleep, na.rm = T)
```

```
## [1] 0.7597
```

```r
median(data.filter$sleep, na.rm = T)
```

```
## [1] 7
```



### 9. Perform a stratified analysis of mean outlook on life by alcohol consumption (i.e., What is the mean score for outlook on life for each amount of alcohol consumed?). What is the mean score for those who indicated that they have 5 drinks?

Stratifying on number of drinks, we can see the mean outlook on life (optimism).

```r
tapply(X = data$optimism, INDEX = data$alcohol, mean, na.rm = T)
```

```
##     0     1     2     3     4     5     6     7     8 
## 79.17 77.90 88.14 60.44 70.00 74.50 78.50 90.00 75.00
```

```r
tapply(X = data.filter$optimism, INDEX = data.filter$alcohol, mean, na.rm = T)
```

```
##     0     1     2     3     5     6 
## 90.00 87.75 93.67 81.00 67.67 67.00
```


Those who have had 5 drinks indicated a 74.5 level of optimism.

### 10. How many people consider themselves street smart? (Hint: Another way of phrasing this question is ‘what is the frequency of people who consider themselves street smart?’)

Presumably this means the opposite of IsBookSmart.

```r
table(data$IsBookSmart, useNA = "ifany")
```

```
## 
##    0    1 <NA> 
##    9   40    7
```

```r
table(data.filter$IsBookSmart, useNA = "ifany")
```

```
## 
##  0  1 
##  5 12
```

Nine people consider themselves street smart.

### 11. Create a box plot for ‘fruitveg’. What does the black dot in the figure represent?

```r
boxplot(data$fruitveg, pch = 19)
```

![plot of chunk unnamed-chunk-22](figure/unnamed-chunk-22.png) 

That black dot represents an outlier that is more than 1.5 times the IQR beyond the 75th percentile.

### 12. Re-examine the relationship of mean outlook on life by alcohol consumption using a group box plot. 

```r
boxplot(optimism ~ alcohol, data = data, xlab = "Number of alcoholic drinks/week", 
    ylab = "Optimism score", varwidth = T)
```

![plot of chunk unnamed-chunk-23](figure/unnamed-chunk-23.png) 

