Homework 2
========================================================

Input separate tables for person time and risks to make it easier for later calculations


~~~
Table.person.time <- matrix(c(20, 4, 2698, 2699), 2, 2)
rownames(Table.person.time) <- c("Vioxx", "naproxen")
colnames(Table.person.time) <- c("Heart attacks", "Person-years")
Table.person.time
~~~

~~~
##          Heart attacks Person-years
## Vioxx               20         2698
## naproxen             4         2699
~~~

~~~

Table.events <- matrix(c(20, 4, 4047 - 20, 4029 - 4), 2, 2)
rownames(Table.events) <- c("Vioxx", "naproxen")
colnames(Table.events) <- c("Heart attacks", "No heart attacks")
Table.events
~~~

~~~
##          Heart attacks No heart attacks
## Vioxx               20             4027
## naproxen             4             4025
~~~


### Question 1.
What is the absolute difference in the incidence rates of heart attacks for Vioxx versus Naproxen? Please calculate as events per 1000 person-years and round to the nearest tenth (e.g., x.x); do not write the units when entering your answer.


~~~
Vioxx.rate <- Table.person.time[1, 1]/Table.person.time[1, 2]
Vioxx.rate
~~~

~~~
## [1] 0.007413
~~~

~~~
naproxen.rate <- Table.person.time[2, 1]/Table.person.time[2, 2]
naproxen.rate
~~~

~~~
## [1] 0.001482
~~~

~~~
round(1000 * (Vioxx.rate - naproxen.rate), digits = 1)
~~~

~~~
## [1] 5.9
~~~


Also you can use the `epi.2by2` function from the `epiR` package to calculate the most commonly used estimates from the table.


~~~
library(epiR)
~~~

~~~
## Loading required package: survival
~~~

~~~
## Loading required package: splines
~~~

~~~
## Package epiR 0.9-48 is loaded
~~~

~~~
## Type help(epi.about) for summary information
~~~

~~~
epi.2by2(Table.person.time, method = "cohort.time")
~~~

~~~
##              Disease +    Time at risk        Inc rate *
## Exposed +           20            2698             0.741
## Exposed -            4            2699             0.148
## Total               24            5397             0.445
## 
## Point estimates and 95 % CIs:
## ---------------------------------------------------------
## Inc rate ratio                           5 (1.68, 20.13)
## Attrib rate *                            0.59 (0.24, 0.95)
## Attrib rate in population *              0.3 (0.07, 0.53)
## Attrib fraction in exposed (%)           80.01 (40.32, 95.03)
## Attrib fraction in population (%)        66.67 (42.65, 79.93)
## ---------------------------------------------------------
##  * Cases per 100 units of population time at risk
~~~



### Question 2.
What is the absolute difference in the risk of heart attacks for Vioxx versus Naproxen? Please report as a percentage, rounded to the nearest hundredth (e.g., .xx). Do not include the % sign.


~~~
Vioxx.risk <- Table.events[1, 1]/sum(Table.events[1, ])
naproxen.risk <- Table.events[2, 1]/sum(Table.events[2, ])
(Vioxx.risk - naproxen.risk) * 100
~~~

~~~
## [1] 0.3949
~~~


Again, you can also use the `epi.2by2` function to do this:


~~~
epi.2by2(Table.events)
~~~

~~~
##              Disease +    Disease -      Total        Inc risk *
## Exposed +           20         4027       4047            0.4942
## Exposed -            4         4025       4029            0.0993
## Total               24         8052       8076            0.2972
##                  Odds
## Exposed +    0.004966
## Exposed -    0.000994
## Total        0.002981
## 
## Point estimates and 95 % CIs:
## ---------------------------------------------------------
## Inc risk ratio                         4.98 (1.7, 14.55)
## Odds ratio                             5 (1.67, 20.11)
## Attrib risk *                          0.39 (0.16, 0.63)
## Attrib risk in population *            0.2 (0.04, 0.35)
## Attrib fraction in exposed (%)         79.91 (41.28, 93.13)
## Attrib fraction in population (%)      66.59 (18.32, 86.34)
## ---------------------------------------------------------
##  * Cases per 100 population units
~~~


### Question 3.
What is the rate ratio comparing Vioxx with Naproxen? Please round to the nearest tenth (e.g., x.x).


~~~
Vioxx.rate/naproxen.rate
~~~

~~~
## [1] 5.002
~~~


### Question 4.
What is the number needed to harm? Round to the nearest whole number.

Number needed to harm is the inverse of the absolute risk difference.

~~~
1/(Vioxx.rate - naproxen.rate)
~~~

~~~
## [1] 168.6
~~~


We can extract risk difference (Attrib risk, or AR) from the `epi.2by2` output with the `verbose = T` option.


~~~
risk.diff <- epi.2by2(Table.events, method = "cohort.count", verbose = T)$AR/100
risk.diff
~~~

~~~
##        est       se weight   lower    upper
## 1 0.003949 0.001209   6843 0.00158 0.006318
~~~

~~~
1/risk.diff  # NNT
~~~

~~~
##     est    se    weight lower upper
## 1 253.2 827.2 0.0001461   633 158.3
~~~


### Question 5.
What percent of single-pill users were hospitalized during follow-up? (do not include the % sign)

~~~
one.pill.risk <- 7.7/100
~~~



### Question 6.
What percent of three-or-more-pill users were hospitalized during follow-up? (eg. x.x, do not include the % sign)


~~~
three.pill.risk <- 9.9/100
~~~


### Question 7.
Calculate the risk ratio comparing the risk of hospitalization in single-pill users versus three-or-more-pill users. Round to the nearest hundredth (e.g., .xx).


~~~
one.pill.risk/three.pill.risk
~~~

~~~
## [1] 0.7778
~~~


### Question 8.
Calculate the odds ratio comparing the odds of hospitalization in single-pill users versus three-or-more-pill users. Round to the nearest hundredth (e.g., .xx).

~~~
one.pill.odds <- one.pill.risk/(1 - one.pill.risk)
three.pill.odds <- three.pill.risk/(1 - three.pill.risk)
~~~

Odds ratio

~~~
one.pill.odds/three.pill.odds
~~~

~~~
## [1] 0.7592
~~~


### Question 10.
The adjusted odds ratio comparing the 1.0 mg tesofensine group with the placebo group for the outcome of a weight loss of 5kg or more was 31.5. Calculate the unadjusted risk ratio for this comparison (using the percentages given in the table). Round to the nearest tenth (e.g., x.x).


~~~
Table10 <- matrix(c(42, 13, 4, 32), 2, 2)
rownames(Table10) <- c("tesofensine 1.0 mg", "placebo")
colnames(Table10) <- c("loss >= 5 kg", "loss < 5 kg")
Table10
~~~

~~~
##                    loss >= 5 kg loss < 5 kg
## tesofensine 1.0 mg           42           4
## placebo                      13          32
~~~

~~~
Table10.prop <- prop.table(Table10, 1)
Table10.prop
~~~

~~~
##                    loss >= 5 kg loss < 5 kg
## tesofensine 1.0 mg       0.9130     0.08696
## placebo                  0.2889     0.71111
~~~

~~~
Table10.prop[1, 1]/Table10.prop[2, 1]
~~~

~~~
## [1] 3.161
~~~

The accepted answer was 3.1, presumably because of rounding.

Alternately we can use the `epi.2by2` function from the `epiR` package. See `?epi.2by2` to see how you have to arrange the tables you give the function.


~~~
library(epiR)
epi.2by2(Table10, method = "cohort.count")
~~~

~~~
##              Disease +    Disease -      Total        Inc risk *
## Exposed +           42            4         46              91.3
## Exposed -           13           32         45              28.9
## Total               55           36         91              60.4
##                  Odds
## Exposed +      10.500
## Exposed -       0.406
## Total           1.528
## 
## Point estimates and 95 % CIs:
## ---------------------------------------------------------
## Inc risk ratio                         3.16 (1.98, 5.04)
## Odds ratio                             24.64 (7.01, 114.27)
## Attrib risk *                          62.42 (46.87, 77.96)
## Attrib risk in population *            31.55 (14.93, 48.17)
## Attrib fraction in exposed (%)         68.36 (49.53, 80.17)
## Attrib fraction in population (%)      52.2 (30.66, 67.05)
## ---------------------------------------------------------
##  * Cases per 100 population units
~~~

### Question 11.
The adjusted odds ratio comparing the1.0 mg tesofensine group with the placebo group for the outcome of a weight loss of 5kg or more was 31.5. Calculate the adjusted risk ratio for this comparison using the conversion formula below. Round to the nearest tenth (e.g., x.x).


~~~
OR.1 <- 31.5
P.ref <- Table10.prop[2, 1]
OR.1/((1 - P.ref) + (P.ref * OR.1))
~~~

~~~
## [1] 3.211
~~~

