Unit 1 Homework
=======

Unit 1 Homework - Question Set 1
----
## A doctor examines a group of healthy adults (presenting to clinic for their annual physical exams) and records their respiratory rates, shown in the following table.


```r
resp <- c(rep(11, 10), rep(12, 9), rep(13, 11), rep(14, 14), rep(15, 10), rep(16, 
    6))
table(resp)
```

```
## resp
## 11 12 13 14 15 16 
## 10  9 11 14 10  6
```


### a. Calculate the mean of the sample data (n=60). Please enter your answer to one decimal place (e.g., xx.x). 


```r
round(mean(resp), digits = 1)
```

```
## [1] 13.4
```


### b. Calculate the standard deviation of the sample data (n=60). Please enter your answer to two decimal places (e.g., xx.xx).


```r
round(sd(resp), digits = 2)
```

```
## [1] 1.58
```


### c. What is the median value? Please enter your answer to one decimal place (e.g., xx.x).


```r
round(median(resp), digits = 1)
```

```
## [1] 13.5
```


### d. What is the interquartile range? Your answer should be a whole number. 


```r
IQR(resp)
```

```
## [1] 3
```


### e. Which of the following histograms correctly pictures the data?


```r
prop.table(table(resp))
```

```
## resp
##     11     12     13     14     15     16 
## 0.1667 0.1500 0.1833 0.2333 0.1667 0.1000
```

```r
barplot(prop.table(table(resp)), xlab = "Respiratory Rate", ylab = "Percentage")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


Unit 1 Homework - Question Set 2
-----
## When you flip a coin, there are two possible outcomes: {0=tails, 1=heads}. Each outcome occurs with equal probability. As an experiment, you flip a coin 100 times, with the following result:

### Encode data

```r
coinflip <- c(rep(0, 53), rep(1, 47))
table(coinflip)
```

```
## coinflip
##  0  1 
## 53 47
```


### a.  Calculate the mean of your sample data (n=100). Please enter your value to two decimal places (e.g., .xx).

```r
round(mean(coinflip), 2)
```

```
## [1] 0.47
```


### b.  Calculate the standard deviation of your sample data (n=100). Please enter to two decimal places (e.g., .xx).

```r
round(sd(coinflip), digits = 2)
```

```
## [1] 0.5
```


### c.  What is the median value? Please enter a whole number.

```r
median(coinflip)
```

```
## [1] 0
```


### d.  What is the interquartile range? Please enter a whole number.

```r
IQR(coinflip)
```

```
## [1] 1
```

