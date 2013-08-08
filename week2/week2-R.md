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
data(rats)
~~~

To learn more about the dataset, type `?rats`.  

We will be interested in only 3 variables: `rx`, `time`, and `status`. As you can see in the help page for the dataset, `rx` is treatment (1=drug, 0=control), `time` is time to tumor or last follow-up, and `status` is event status (1=tumor, 0=censored/no tumor).

### Questions
1. Convert `rx` and `status` into factor variables. If you can, also label the levels with the appropriate names (i.e., drug, control, tumor, censored).
2. Create a 2x2 table with `rx` on the rows and `status` on the columns.
3. Using the table, what is the risk of tumor in the drug (`rx` = 1) group? What is the risk of tumor in the control (`rx` = 0) group?
4. What is the risk ratio of tumor in the drug group versus the control group? What is the odds ratio? What is the risk difference? 
5. How much person-time (rat-time?) was observed in rats receiving the drug (`rx` = 1)? How much person-time was observed in rats receiving the control (`rx` = 0)?
6. Create a 2x2 table with the rows being the `rx` groups and the first column being the number of tumors in each group and the second column being person time in each group.
7. What is the rate ratio comparing tumor rate in the drug and control groups? What is the rate difference? What is the number needed to harm?
