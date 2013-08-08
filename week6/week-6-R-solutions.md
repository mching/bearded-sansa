Week 6 R Extra Exercise
====

There's not much to be learned with R this week, but we can go over a little of the sample size calculation.

The standard `stats` package comes with `power.t.test` and `power.prop.test` for the examples shown in the optional module. These tests assume equal sample sizes. See [`power.t.test`](http://stat.ethz.ch/R-manual/R-patched/library/stats/html/power.t.test.html) and [`power.prop.test`](http://stat.ethz.ch/R-manual/R-patched/library/stats/html/power.prop.test.html) for more.

The basic idea is that you specify 3 of the following 4 variables: sample size, difference in means, standard deviation, and power. The function will calculate the one you leave out. 

1. What sample size do you need for a difference in means of 0.5 given a standard deviation of 1, significance level of 0.05, power of 0.80?


~~~
power.t.test(n = NULL, delta = 0.5, sd = 1, sig.level = 0.05, power = 0.8)
~~~

~~~
## 
##      Two-sample t test power calculation 
## 
##               n = 63.77
##           delta = 0.5
##              sd = 1
##       sig.level = 0.05
##           power = 0.8
##     alternative = two.sided
## 
## NOTE: n is number in *each* group
~~~


2. What is the power to detect a 10 point difference in means given a sample size of 30 in both groups, significance level of 0.05, and standard deviation of 50?


~~~
power.t.test(n = 30, delta = 10, sd = 50, sig.level = 0.05, power = NULL)
~~~

~~~
## 
##      Two-sample t test power calculation 
## 
##               n = 30
##           delta = 10
##              sd = 50
##       sig.level = 0.05
##           power = 0.1154
##     alternative = two.sided
## 
## NOTE: n is number in *each* group
~~~


3. How many people do you need to detect a difference in proportions of 5% (specifically 10% versus 15%) at a significance level of 0.05 with 90% power?


~~~
power.prop.test(n = NULL, p1 = 0.1, p2 = 0.15, sig.level = 0.05, power = 0.9)
~~~

~~~
## 
##      Two-sample comparison of proportions power calculation 
## 
##               n = 917.3
##              p1 = 0.1
##              p2 = 0.15
##       sig.level = 0.05
##           power = 0.9
##     alternative = two.sided
## 
## NOTE: n is number in *each* group
~~~


4. What is your power to detect a difference in proportions of 25% (50% vs 75%) with a sample size of 50 per group and significance level of 0.10?


~~~
power.prop.test(n = 50, p1 = 0.5, p2 = 0.75, sig.level = 0.1, power = NULL)
~~~

~~~
## 
##      Two-sample comparison of proportions power calculation 
## 
##               n = 50
##              p1 = 0.5
##              p2 = 0.75
##       sig.level = 0.1
##           power = 0.834
##     alternative = two.sided
## 
## NOTE: n is number in *each* group
~~~


For different sample sizes, you need a new package, for example, [`pwr`](http://cran.r-project.org/web/packages/pwr/index.html). [This page](http://www.statmethods.net/stats/power.html) describes the usage in more detail.

1. What is the smallest effect size (difference divided by standard deviation) that can be observed when comparing the means of a group of 50 and 100 people at a power of 0.85?


~~~
library(pwr)
pwr.t2n.test(n1 = 50, n2 = 100, d = NULL, sig.level = 0.05, power = 0.85, alternative = "two.sided")
~~~

~~~
## 
##      t test power calculation 
## 
##              n1 = 50
##              n2 = 100
##               d = 0.5224
##       sig.level = 0.05
##           power = 0.85
##     alternative = two.sided
~~~

