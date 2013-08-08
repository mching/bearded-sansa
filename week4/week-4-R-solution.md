Week 4 R Exercise
====

## Introduction to Probability Distributions in R

R has many built in probability distributions including the normal, binomial, chi-squared, Student's t, and Poisson. For more information, see `?distributions`.  

Each distribution comes with four functions for calculating the probability density, cumulative probability, quantile, and random number generation. They are respectively named `dfoo`, `pfoo`, `qfoo`, `rfoo` where `foo` stands in for the distribution name. 

For example, in the normal distribution, these functions are `dnorm`, `pnorm`, `qnorm`, and `rnorm`. Use `?dnorm` to learn how to use this function. Other functions include `dbinom`, `dt`, `dchisq` and `dpois`.

## Exercises
Q1.  What is the probability of obtaining *exactly 10* sixes when you roll 60 dice one time?


~~~
dbinom(x = 10, size = 60, prob = 1/6)
~~~

~~~
## [1] 0.137
~~~


Q2.  What is the probability of obtaining *10 or fewer* sixes when you roll 60 dice one time?


~~~
pbinom(q = 10, size = 60, prob = 1/6)
~~~

~~~
## [1] 0.5834
~~~

~~~
sum(dbinom(0:10, 60, 1/6))
~~~

~~~
## [1] 0.5834
~~~


Q3.  What is the probability of obtaining *10 or more* sixes when you roll 60 dice one time?


~~~
1 - pbinom(q = 9, size = 60, prob = 1/6)
~~~

~~~
## [1] 0.5536
~~~

~~~
pbinom(q = 9, size = 60, prob = 1/6, lower.tail = FALSE)
~~~

~~~
## [1] 0.5536
~~~

~~~
sum(dbinom(10:60, 60, 1/6))
~~~

~~~
## [1] 0.5536
~~~


Q4.  Plot the probability of obtaining 0, 1, 2, 3, ..., 60 sixes when you roll 60 dice one time.


~~~
x <- 0:60
plot(x, dbinom(x, 60, 1/6), type = "h")
~~~

Q5.  The national prevalence of texting while driving among U.S. high school boys was found to be 46.4% ([Olsen et al 2013][1]). If you survey 200 boys in a high school class and 80 of them admit to texting while driving, how likely is this to occur if the prevalence in this group is actually the same as nationally (i.e., what is the probability that 80 or fewer boys admit to texting while driving)?


~~~
pbinom(80, 200, p = 0.464)
~~~

~~~
## [1] 0.04014
~~~


Q6.  Assume that the blood level of the experimental drug HRP258 is normally distributed with a mean of 70 and a standard deviation of 21. What is the probability that a person's level is between 50 and 100? 


~~~
pnorm(100, mean = 70, sd = 21) - pnorm(50, 70, 21)
~~~

~~~
## [1] 0.753
~~~


Q7.  What is the value of z that corresponds to the cumulative p value of 0.025 in the standard normal distribution? In a normal distribution with mean = 24 and standard deviation = 4?


~~~
qnorm(0.025)
~~~

~~~
## [1] -1.96
~~~

~~~
qnorm(0.025, mean = 24, sd = 4)
~~~

~~~
## [1] 16.16
~~~


Q8. Load the dataset `mgus` from the `survival` package. This dataset refers to monoclonal gammopathy of uncertain significance (`?mgus` for more information).


~~~
library(survival)
~~~

~~~
## Loading required package: splines
~~~

~~~
data(mgus)
~~~


Is the albumin level at MGUS diagnosis normally distributed?

~~~
hist(mgus$alb)
qqnorm(mgus$alb)
~~~


The histogram looks approximately normally distributed. On the QQ plot, it looks like the values at the ends of the plot are not along the same line as the ones in the middle.

[1]: http://pediatrics.aappublications.org/content/131/6/e1708.full
