Week 5 R
====

Part 1: Simulation of Probability Distributions Using R
------
### Part 1 Problems

 Q1. Simulate flipping 20 coins 10 times. Set seed as `set.seed(100)`.


~~~
set.seed(100)
rbinom(10, 20, 0.5)
~~~

~~~
##  [1]  9  9 10  6 10 10 12  9 10  8
~~~


Q2. Simulate rolling a die 100 times. Assuming rolling a 6 is a success, how many of those times did you roll a 6? Set seed as `set.seed(101)`

~~~
set.seed(101)
x <- rbinom(100, 1, 1/6)
sum(x)
~~~

~~~
## [1] 18
~~~


Q3. You have 10 dice in a cup. You roll the dice and count how many 6s you get. You repeat this 100 times. How many times did you roll a 6 on each trial? On how many of the trials did you roll no sixes? Set seed as `set.seed(105)`

~~~
set.seed(105)
x <- rbinom(100, 10, 1/6)
sum(x)
~~~

~~~
## [1] 170
~~~

~~~
length(which(x == 0))
~~~

~~~
## [1] 12
~~~


Q4. Simulate the blood pressures of 20 individuals randomly drawn from a population with a mean blood pressure 120 and standard deviation of 10. What is the mean and standard deviation of the sample? Set seed as `set.seed(142)`.

~~~
set.seed(142)
bp <- rnorm(20, 120, 10)
mean(bp)
~~~

~~~
## [1] 122.9
~~~

~~~
sd(bp)
~~~

~~~
## [1] 9.216
~~~


Q5. Simulate the mean blood pressures of 1000 samples of 20 individuals drawn from the same population. What is the mean of the sample means? What is the standard deviation of the sample means? What is the theoretical standard error of the mean? How many of the sample means in this example are more than two s.e.m. from the population mean? Set seed as `set.seed(224)`


~~~
set.seed(224)
x <- rep(NA, 1000)
for (i in 1:1000) {
    x[i] <- mean(rnorm(20, 120, 10))
}
mean(x)
~~~

~~~
## [1] 119.9
~~~

~~~
sd(x)
~~~

~~~
## [1] 2.164
~~~

~~~
pred.sem <- 10/sqrt(20)
pred.sem
~~~

~~~
## [1] 2.236
~~~

~~~
length(which(x < 120 - 2 * pred.sem | x > 120 + 2 * pred.sem))
~~~

~~~
## [1] 37
~~~


Part 2: Odds Ratio Estimation
-------

We can simulate data for a case control study to practice calculating the odds ratio. Let's assume the prevalence of exposure in cases is 0.2, and the prevalence of exposure in controls is 0.1. We can generate some pseudo-random data using the code below.


~~~
set.seed(706)
disease <- c(rep(1, 1000), rep(0, 1000))
exposure <- c(rbinom(1000, 1, 0.2), rbinom(1000, 1, 0.1))
~~~


Reorder factor (not actually necessary here since the OR will be the same)


~~~
disease <- factor(disease, levels = 1:0, labels = c("case", "control"))
exposure <- factor(exposure, levels = 1:0, labels = c("exposed", "not exposed"))
Table1 <- table(exposure, disease)
Table1
~~~

~~~
##              disease
## exposure      case control
##   exposed      195     106
##   not exposed  805     894
~~~


Q1. What is the odds ratio?


~~~
a <- Table1[1, 1]
b <- Table1[1, 2]
c <- Table1[2, 1]
d <- Table1[2, 2]
OR1 <- (a/b)/(c/d)  # OR
OR1
~~~

~~~
## [1] 2.043
~~~


Q2. What is the standard error of the natural log of the odds ratio?


~~~
seOR <- sqrt(1/a + 1/b + 1/c + 1/d)
seOR
~~~

~~~
## [1] 0.1301
~~~


Q3. What is the 95% confidence interval for the natural log of the odds ratio?


~~~
log(OR1) + qnorm(0.025) * seOR
~~~

~~~
## [1] 0.4595
~~~

~~~
log(OR1) + qnorm(0.975) * seOR
~~~

~~~
## [1] 0.9694
~~~


Q4. What is the 95% confidence interval for the odds ratio?


~~~
exp(log(OR1) + qnorm(0.025) * seOR)
~~~

~~~
## [1] 1.583
~~~

~~~
exp(log(OR1) + qnorm(0.975) * seOR)
~~~

~~~
## [1] 2.636
~~~


Q5. Install the package `epitools` (`install.packages("epitools")`) and use its `oddsratio` function to calculate the odds ratio. Type `?oddsratio` for help in using the function. Compare your result to Q1 and Q4.

The odds ratio estimate is slightly different unless you use the `method = "wald"` argument gives you the method taught in class.

~~~
library(epitools)
oddsratio(Table1)
~~~

~~~
## $data
##              disease
## exposure      case control Total
##   exposed      195     106   301
##   not exposed  805     894  1699
##   Total       1000    1000  2000
## 
## $measure
##              odds ratio with 95% C.I.
## exposure      estimate lower upper
##   exposed        1.000    NA    NA
##   not exposed    2.041 1.585 2.641
## 
## $p.value
##              two-sided
## exposure      midp.exact fisher.exact chi.square
##   exposed             NA           NA         NA
##   not exposed   2.28e-08    3.083e-08   2.61e-08
## 
## $correction
## [1] FALSE
## 
## attr(,"method")
## [1] "median-unbiased estimate & mid-p exact CI"
~~~

~~~
oddsratio(Table1, method = "wald")
~~~

~~~
## $data
##              disease
## exposure      case control Total
##   exposed      195     106   301
##   not exposed  805     894  1699
##   Total       1000    1000  2000
## 
## $measure
##              odds ratio with 95% C.I.
## exposure      estimate lower upper
##   exposed        1.000    NA    NA
##   not exposed    2.043 1.583 2.636
## 
## $p.value
##              two-sided
## exposure      midp.exact fisher.exact chi.square
##   exposed             NA           NA         NA
##   not exposed   2.28e-08    3.083e-08   2.61e-08
## 
## $correction
## [1] FALSE
## 
## attr(,"method")
## [1] "Unconditional MLE & normal approximation (Wald) CI"
~~~

