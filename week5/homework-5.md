Homework 5
========================================================

### Question 2:

In a study of 13 children with cystic fibrosis who completed an exercise program, exercise endurance (duration on an exercise test) improved by a mean of 0.77 minutes. The standard deviation for the change in endurance was 0.83 minutes. What is the theoretical distribution of the mean?


~~~
sem2 <- 0.83/(13)^0.5
sem2
~~~

~~~
## [1] 0.2302
~~~


### Question 3:

Thirty heart disease patients are put on an exercise regimen. Twenty patients improve on the exercise stress test and ten don’t improve or get worse. Calculate the 95% confidence interval for the true proportion of heart disease patients who improve their fitness using this particular exercise regimen. Recall that proportions are normally distributed with a standard error of

$\sqrt{\frac{p(1-p)}{n}}$


~~~
library(binom)
~~~

~~~
## Loading required package: lattice
~~~

~~~
binom.confint(20, 30, conf.level = 0.95, methods = "asymptotic")
~~~

~~~
##       method  x  n   mean lower  upper
## 1 asymptotic 20 30 0.6667 0.498 0.8354
~~~


### Question 4:

The following data were collected from a case-control study of breast cancer and fat intake:

 | case  | control
--- | --- | ---
High-fat diet	| 10	| 5
Low-fat diet	| 40	| 55
 | 50 |	60

Statistical inferences for odds ratios are based on the natural log of the odds ratio, rather than the odds ratio itself (because the distribution for an odds ratio does not follow a normal distribution). The sampling distribution of the natural log of the odds ratio (lnOR) follows a normal distribution, with standard error

$se = \sqrt{\frac{1}{a}+\frac{1}{b}+\frac{1}{c}+\frac{1}{d}}$

(where a, b, c, and d are the cells in the 2x2 table).

Calculate the odds ratio for breast cancer (comparing high-fat diet to low-fat diet) from the 2x2 table above.


~~~
Table4 <- matrix(c(10, 40, 5, 55), nrow = 2)
rownames(Table4) <- c("High-fat diet", "Low-fat diet")
colnames(Table4) <- c("case", "control")
Table4
~~~

~~~
##               case control
## High-fat diet   10       5
## Low-fat diet    40      55
~~~


Odds Ratio

~~~
OR.4 <- 10 * 55/(5 * 40)
OR.4
~~~

~~~
## [1] 2.75
~~~


### Question 5:

Take the natural log of the odds ratio that you calculated in question 4.


~~~
log(OR.4)
~~~

~~~
## [1] 1.012
~~~


### Question 6:

Calculate the standard error of the lnOR, according to the formula given above.


~~~
se.6 <- (1/Table4[1, 1] + 1/Table4[1, 2] + 1/Table4[2, 1] + 1/Table4[2, 2])^0.5
se.6
~~~

~~~
## [1] 0.5858
~~~


### Question 7:

Calculate the 95% confidence interval for the lnOR.


~~~
log(OR.4) + qnorm(0.025) * se.6
~~~

~~~
## [1] -0.1366
~~~

~~~
log(OR.4) + qnorm(0.975) * se.6
~~~

~~~
## [1] 2.16
~~~


### Question 8:

Convert the upper and lower confidence limits that you calculated in (e) back to odds ratios by exponentiating (i.e., calculate the 95% confidence interval for the OR).


~~~
exp(log(OR.4) + qnorm(0.025) * se.6)
~~~

~~~
## [1] 0.8723
~~~

~~~
exp(log(OR.4) + qnorm(0.975) * se.6)
~~~

~~~
## [1] 8.669
~~~


There are a variety of functions that can help with this calculation.

The package `epitools` has an `oddsratio` function that allows you to use different methods to calculate the odds ratio and 95% confidence interval. Use `install.packages("epitools")` to add on this package if you don't already have it. The `method = "wald"` argument gives you the method taught in class. 


~~~
library(epitools)
~~~

~~~
## Attaching package: 'epitools'
~~~

~~~
## The following object is masked from 'package:binom':
## 
## binom.exact, binom.wilson
~~~

~~~
oddsratio(Table4, method = "wald")
~~~

~~~
## $data
##               case control Total
## High-fat diet   10       5    15
## Low-fat diet    40      55    95
## Total           50      60   110
## 
## $measure
##                         NA
## odds ratio with 95% C.I. estimate  lower upper
##            High-fat diet     1.00     NA    NA
##            Low-fat diet      2.75 0.8723 8.669
## 
## $p.value
##                NA
## two-sided       midp.exact fisher.exact chi.square
##   High-fat diet         NA           NA         NA
##   Low-fat diet     0.08693      0.09682    0.07583
## 
## $correction
## [1] FALSE
## 
## attr(,"method")
## [1] "Unconditional MLE & normal approximation (Wald) CI"
~~~


### Question 11:

A hypothetical HIV vaccine trial involving 20,000 participants—10,000 in the vaccine group and 10,000 in the placebo group—had the following results: 6.3 infections per 1000 in the vaccine group and 9.0 infections per 1000 in the placebo group.

I ran a computer simulation to predict possible outcomes of the trial if the null hypothesis is true—that is, if vaccinated and unvaccinated people are equally likely to contract HIV. I ran 1000 virtual trials of 20,000 people (10,000 per group) assuming that the vaccine is ineffective. Outcomes are expressed as excess infections in the placebo group. Here are the results of the 1000 virtual trials displayed as a histogram.

There were 9-6.3 or 2.7 excess infections per 1000. Since the simulation was on 10,000 individuals, the excess was 27 (2.7*10000/1000). For the two sided value, we refer to the histogram and count how many are to the left of -27 and to the right of 27. This gives the answer as shown in the solution.

### Question 12:

From the simulation, I learn that the statistic ‘excess infections in the placebo group’ follows a normal distribution with a mean of 0 and a standard deviation (standard error) of 12.3. Use this information to calculate the two-sided p-value more precisely than in (11). Round to the nearest thousandth.

There were 9-6.3 or 2.7 excess infections per 1000. Since the simulation was on 10,000 individuals, the excess was 27 (2.7*10000/1000). 


~~~
2 * pnorm(27, mean = 0, sd = 12.3, lower.tail = F)
~~~

~~~
## [1] 0.02815
~~~

