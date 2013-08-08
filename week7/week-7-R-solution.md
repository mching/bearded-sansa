Week 7 R
=====
### Survival Analysis in R

### Problems

1. Load the National Wilms Tumor dataset (`data(nwtco)`) from the survival package.


~~~
library(survival)
~~~

~~~
## Loading required package: splines
~~~

~~~
data(nwtco)
str(nwtco)
~~~

~~~
## 'data.frame':	4028 obs. of  9 variables:
##  $ seqno       : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ instit      : int  2 1 2 2 2 1 1 1 1 2 ...
##  $ histol      : int  2 1 2 1 2 1 1 1 1 1 ...
##  $ stage       : int  1 2 1 4 2 2 4 2 1 2 ...
##  $ study       : int  3 3 3 3 3 3 3 3 3 3 ...
##  $ rel         : int  0 0 0 0 0 0 1 0 0 0 ...
##  $ edrel       : int  6075 4121 6069 6200 1244 2932 324 5408 5215 1381 ...
##  $ age         : int  25 50 9 28 55 32 45 44 123 31 ...
##  $ in.subcohort: logi  FALSE FALSE FALSE TRUE FALSE FALSE ...
~~~


2. Create the survey object using `rel` (relapse) as the event and `edrel` (time to relapse) as the time.


~~~
surv.object <- Surv(time = nwtco$edrel, event = nwtco$rel)
~~~



3. Fit the survival curve and plot it.


~~~
survfit(surv.object ~ 1)
~~~

~~~
## Call: survfit(formula = surv.object ~ 1)
## 
## records   n.max n.start  events  median 0.95LCL 0.95UCL 
##    4028    4028    4028     571      NA      NA      NA
~~~

~~~
plot(survfit(surv.object ~ 1))
~~~

*Run command in R to see the plot*


4. Compare time to relapse by the tumor pathology reported by the local institution (variable name is `instit`). Plot the survival curve by local institution tumor pathology.


~~~
survfit(surv.object ~ nwtco$instit)
~~~

~~~
## Call: survfit(formula = surv.object ~ nwtco$instit)
## 
##                records n.max n.start events median 0.95LCL 0.95UCL
## nwtco$instit=1    3622  3622    3622    415     NA      NA      NA
## nwtco$instit=2     406   406     406    156     NA      NA      NA
~~~

~~~
plot(survfit(surv.object ~ nwtco$instit), col = c("red", "blue"), xlab = "time", 
    ylab = "percent without relapse")
legend(x = "bottomleft", legend = "Red = Pathology #1, Blue = Pathology #2")
~~~

*Run command in R to see the plot*


5. Test the null hypothesis that the two survival curves for both pathology types are equal.


~~~
survdiff(surv.object ~ nwtco$instit)
~~~

~~~
## Call:
## survdiff(formula = surv.object ~ nwtco$instit)
## 
##                   N Observed Expected (O-E)^2/E (O-E)^2/V
## nwtco$instit=1 3622      415    523.4      22.4       269
## nwtco$instit=2  406      156     47.6     246.4       269
## 
##  Chisq= 269  on 1 degrees of freedom, p= 0
~~~

