MOOC: R Exercise 2
====


```r
download.file(url = "https://s3-us-west-1.amazonaws.com/prod-edx/MedStats/RegressionExerciseDocs/mock_class_data.csv", 
    destfile = "mock_class_data.csv", method = "curl")
dat <- read.csv("./mock_class_data.csv")
```



### Q1. You are interested in determining whether varsity athletes in high school exercise more than those students who were not varsity athletes in high school.

Look at data first. Exercise doesn't appear to be normally distributed but we do have a large number of individuals so maybe it won't be a problem.

```r
str(dat$exercise)
```

```
##  num [1:56] 2 0 3 3 2 3 2.5 10 3.5 3.5 ...
```

```r
hist(dat$exercise)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 



```r
str(dat$Varsity)
```

```
##  int [1:56] 0 1 1 1 0 1 1 1 1 0 ...
```

```r
dat$Varsity.factor <- factor(dat$Varsity, levels = 1L:0L, labels = c("Varsity", 
    "Non-Varsity"))
```


#### Q1a. What statistical test would you use to make this comparison? Why?

T-test, two groups seems appropriate initially. What about the variances?


```r
tapply(dat$exercise, dat$Varsity.factor, sd)
```

```
##     Varsity Non-Varsity 
##       2.896       2.535
```

```r
var.test(exercise ~ Varsity.factor, data = dat)
```

```
## 
## 	F test to compare two variances
## 
## data:  exercise by Varsity.factor
## F = 1.304, num df = 29, denom df = 19, p-value = 0.5523
## alternative hypothesis: true ratio of variances is not equal to 1
## 95 percent confidence interval:
##  0.5431 2.9106
## sample estimates:
## ratio of variances 
##              1.304
```


They are similar enough. We can try pooled variance test.

#### Q1b. Perform this statistical test. Report the p-value for the test statistic. What are the mean exercise values for each group (varsity vs. non-varsity)? What is your conclusion?


```r
t.test(dat$exercise ~ dat$Varsity.factor, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  dat$exercise by dat$Varsity.factor
## t = 1.224, df = 48, p-value = 0.2268
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.6262  2.5762
## sample estimates:
##     mean in group Varsity mean in group Non-Varsity 
##                     4.550                     3.575
```

Fail to reject the null hypothesis both ways.

#### Q1c. Plot this relationship so that you can visually assess the data.


```r
boxplot(exercise ~ Varsity.factor, data = dat, ylab = "Hours of Exercise/Week", 
    main = "College Student Exercise by High School Varsity Sports Experience")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


### Q2. You are interested in seeing whether, on average, students love math more or love writing more. Using this cohort, you want to compare the “Mathlove” variable and the “Writinglove” variable to determine whether you observe a difference between the two groups.

#### Q2a. What statistical test would you use to make this comparison? Why?

Correlated data, possibly normally distributed, but there are large numbers.

#### Q2b. Explain how this statistical test differs from the test in Q1.

Takes advantage of correlated data.

#### Q2c. Perform this statistical test. Report the p-value for the test statistic. On average, how different are the “love” scores? What is your conclusion?


```r
dat$dLove <- dat$Mathlove - dat$WritingLove
t.test(dat$dLove)
```

```
## 
## 	One Sample t-test
## 
## data:  dat$dLove
## t = 1.687, df = 44, p-value = 0.09874
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  -1.468 16.535
## sample estimates:
## mean of x 
##     7.533
```

Fail to reject the null hypothesis.

### Q3. What is one assumption of the previous two tests? Check this condition for the variable “Writinglove” visually.

Assumption of normality.


```r
hist(dat$WritingLove)
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-81.png) 

```r
qqnorm(dat$WritingLove)
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-82.png) 


### Q4. Based on your observation in Q3, you decide to check the other variables you used in Q1 and Q2. You decide to run the non-parametric version of the test in question 1. 

#### Q4a. What statistical test would you use to make this comparison?

Wilcoxon Rank-Sum test

#### Q4b. Perform this statistical test. Report the p-value for the statistic. Does this change your conclusions from Q1?


```r
wilcox.test(exercise ~ Varsity.factor, data = dat)
```

```
## Warning: cannot compute exact p-value with ties
```

```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  exercise by Varsity.factor
## W = 365.5, p-value = 0.196
## alternative hypothesis: true location shift is not equal to 0
```


### Q5. What menu option would you select to perform an ANOVA? You should be able to find this based on your understanding of the test and what it should be grouped near (i.e., where would it be most logical to find this?)

You can use `lm` or `aov`

### Q6. You are now interested in seeing whether there is a difference in whether you played a varsity sport in high school and whether you consider yourself ‘book smart’ or ‘street smart’. 


```r
str(dat$IsBookSmart)
```

```
##  int [1:56] 1 1 1 1 1 1 1 1 1 1 ...
```

```r
dat$IsBookSmart.factor <- factor(dat$IsBookSmart, levels = 1:0, labels = c("Book Smart", 
    "Street Smart"))
```


#### Q6a. What statistical test would you use in this situation?

Check for sparse data

```r
Table6 <- table(dat$IsBookSmart.factor, dat$Varsity.factor)
Table6
```

```
##               
##                Varsity Non-Varsity
##   Book Smart        25          15
##   Street Smart       4           5
```


The data are too sparse. Need to use Fisher's exact test.

#### Q6b. Perform this statistical test. Report the p-value associated with this test. What is your conclusion?


```r
fisher.test(Table6)
```

```
## 
## 	Fisher's Exact Test for Count Data
## 
## data:  Table6
## p-value = 0.4564
## alternative hypothesis: true odds ratio is not equal to 1
## 95 percent confidence interval:
##   0.3756 12.0935
## sample estimates:
## odds ratio 
##      2.051
```


### Q7. Calculate the risk ratio and the odds ratio (just the point estimates) for considering yourself ‘book smart’ given that you played a varsity sport in high school. (Will need to do this manually based on output from Q6)


```r
Table7 <- table(dat$Varsity.factor, dat$IsBookSmart.factor)
Table7
```

```
##              
##               Book Smart Street Smart
##   Varsity             25            4
##   Non-Varsity         15            5
```


Use of `epitools` can help to automate this.


```r
library(epitools)
riskratio(Table7, method = "wald", rev = "both")
```

```
## Warning: Chi-squared approximation may be incorrect
```

```
## $data
##              
##               Street Smart Book Smart Total
##   Non-Varsity            5         15    20
##   Varsity                4         25    29
##   Total                  9         40    49
## 
## $measure
##              risk ratio with 95% C.I.
##               estimate  lower upper
##   Non-Varsity    1.000     NA    NA
##   Varsity        1.149 0.8584 1.539
## 
## $p.value
##              two-sided
##               midp.exact fisher.exact chi.square
##   Non-Varsity         NA           NA         NA
##   Varsity         0.3515       0.4564     0.3194
## 
## $correction
## [1] FALSE
## 
## attr(,"method")
## [1] "Unconditional MLE & normal approximation (Wald) CI"
```

```r
oddsratio(Table7, method = "wald")
```

```
## Warning: Chi-squared approximation may be incorrect
```

```
## $data
##              
##               Book Smart Street Smart Total
##   Varsity             25            4    29
##   Non-Varsity         15            5    20
##   Total               40            9    49
## 
## $measure
##              odds ratio with 95% C.I.
##               estimate  lower upper
##   Varsity        1.000     NA    NA
##   Non-Varsity    2.083 0.4827 8.992
## 
## $p.value
##              two-sided
##               midp.exact fisher.exact chi.square
##   Varsity             NA           NA         NA
##   Non-Varsity     0.3515       0.4564     0.3194
## 
## $correction
## [1] FALSE
## 
## attr(,"method")
## [1] "Unconditional MLE & normal approximation (Wald) CI"
```

