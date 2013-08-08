HRP 258 Week 2, R Exercise
========================================================
Risk and Rate Ratios
----

This exercise will help you learn how to calculate risk and rate ratios and differences using R or Deducer.

### Loading the Data
We will use the `rats` dataset from the `survival` package.  

If you don't already have this package for some reason, type:
~~~
install.packages("survival")
~~~

To load the dataset type the following:


~~~
library(survival)
~~~

~~~
## Loading required package: splines
~~~

~~~
data(rats)
~~~


To learn more about the dataset, type `?rats`.  

We will be interested in only 3 variables: `rx`, `time`, and `status`. As you can see in the help page for the dataset, `rx` is treatment (1=drug, 0=control), `time` is time to tumor or last follow-up, and `status` is event status (1=tumor, 0=censored). In this case, censored means that there was no tumor the last time they looked at that rat.

### Questions
Q1. Convert `rx` and `status` into factor variables. If you can, also label the levels with the appropriate names (i.e., drug, control, tumor, censored).

~~~
rats$status.factor <- factor(rats$status, levels = 1:0, labels = c("tumor", 
    "censored"))
rats$rx.factor <- factor(rats$rx, levels = 1:0, labels = c("drug", "control"))
~~~


Q2. Create a 2x2 contingency table with `rx` on the rows and `status` on the columns.


~~~
Table1 <- with(rats, table(rx.factor, status.factor))
Table1
~~~

~~~
##          status.factor
## rx.factor tumor censored
##   drug       21       29
##   control    19       81
~~~


Q3. Using this table, what is the risk of tumor in the drug (`rx` = 1) group? What is the risk of tumor in the control (`rx` = 0) group?


~~~
Table1risk <- prop.table(Table1, margin = 1)
Table1risk
~~~

~~~
##          status.factor
## rx.factor tumor censored
##   drug     0.42     0.58
##   control  0.19     0.81
~~~


Q4. Using this table, what is the risk ratio of tumor in the drug group versus the control group? What is the odds ratio? What is the risk difference? 

~~~
Table1risk[1, 1]/Table1risk[2, 1]  # Risk ratio
~~~

~~~
## [1] 2.211
~~~

~~~
(Table1[1, 1]/Table1[1, 2])/(Table1[2, 1]/Table1[2, 2])  # Odds ratio
~~~

~~~
## [1] 3.087
~~~

~~~
Table1risk[1, 1] - Table1risk[2, 1]  # Risk difference
~~~

~~~
## [1] 0.23
~~~


Q5. How much person-time (rat-time?) was observed in rats receiving the drug (`rx` = 1)? How much person-time was observed in rats receiving the control (`rx` = 0)? There are many ways to do this but one way would be to subset the data on `rx` = 1 and see what is the sum of `time`. Then re-subset on `rx` = 0 and see how much person-time there is.


~~~
drug.time <- with(rats, sum(time[rx == 1]))  # drug group
drug.time
~~~

~~~
## [1] 4358
~~~

~~~
control.time <- with(rats, sum(time[rx == 0]))  # control group
control.time
~~~

~~~
## [1] 9056
~~~


Another solution is to use `tapply` to subgroup the data.


~~~
person.time <- tapply(rats$time, rats$rx.factor, sum)
person.time
~~~

~~~
##    drug control 
##    4358    9056
~~~



Q6. Create a 2x2 table with the rows being the `rx` groups and the first column being the number of tumors in each group and the second column being person time in each group.

~~~
Table2 <- matrix(c(Table1[, 1], drug.time, control.time), nrow = 2, ncol = 2)
colnames(Table2) <- c("tumors", "person-time")
rownames(Table2) <- c("drug", "control")
Table2
~~~

~~~
##         tumors person-time
## drug        21        4358
## control     19        9056
~~~



Q7. What is the rate ratio comparing tumor incidence in the drug and control groups? What is the rate difference? What is the number needed to harm?

~~~
rate.drug <- Table2[1, 1]/Table2[1, 2]
rate.control <- Table2[2, 1]/Table2[2, 2]
rate.drug/rate.control  # rate ratio
~~~

~~~
## [1] 2.297
~~~

~~~
rate.drug - rate.control  # rate difference
~~~

~~~
## [1] 0.002721
~~~

~~~
1/(rate.drug - rate.control)  # NNT
~~~

~~~
## [1] 367.6
~~~


An alternate way to do this is to use the `epiR` package. This package has a function called `epi.2by2` that automates much of the calculations above. The only issue is that it requires you to give it tables in a specific orientation (exposures or treatments on the rows and disease on the columns). For more information, see the `epiR` documentation. To install it, type `install.packages("epiR")` at the console.


~~~
library(epiR)
~~~

~~~
## Package epiR 0.9-48 is loaded
~~~

~~~
## Type help(epi.about) for summary information
~~~

Analysis of table containing risk data
~~~
epi.2by2(Table1, method = "cohort.count")
~~~

~~~
##              Disease +    Disease -      Total        Inc risk *
## Exposed +           21           29         50              42.0
## Exposed -           19           81        100              19.0
## Total               40          110        150              26.7
##                  Odds
## Exposed +       0.724
## Exposed -       0.235
## Total           0.364
## 
## Point estimates and 95 % CIs:
## ---------------------------------------------------------
## Inc risk ratio                         2.21 (1.31, 3.72)
## Odds ratio                             3.06 (1.36, 7)
## Attrib risk *                          23 (7.31, 38.69)
## Attrib risk in population *            7.67 (-2.78, 18.12)
## Attrib fraction in exposed (%)         54.76 (23.95, 73.09)
## Attrib fraction in population (%)      28.75 (5.69, 46.17)
## ---------------------------------------------------------
##  * Cases per 100 population units
~~~

Analysis of table containing rate data
~~~
epi.2by2(Table2, method = "cohort.time")
~~~

~~~
##              Disease +    Time at risk        Inc rate *
## Exposed +           21            4358             0.482
## Exposed -           19            9056             0.210
## Total               40           13414             0.298
## 
## Point estimates and 95 % CIs:
## ---------------------------------------------------------
## Inc rate ratio                           2.3 (1.18, 4.52)
## Attrib rate *                            0.27 (0.05, 0.5)
## Attrib rate in population *              0.09 (-0.04, 0.22)
## Attrib fraction in exposed (%)           56.46 (14.92, 77.86)
## Attrib fraction in population (%)        29.64 (19.31, 38.5)
## ---------------------------------------------------------
##  * Cases per 100 units of population time at risk
~~~

NNT. Multiply by 100 because the denominator is in cases per 100 units of person time.  
~~~
1/epi.2by2(Table2, method = "cohort.time", verbose = T)$AR * 100
~~~

~~~
##     est    se lower upper
## 1 367.6 864.7  2202 200.5
~~~

