Unit 3 Homework
====

## Question 1:

### In 1980 (before the era of in-vitro fertilization), there were 3,612,258 births in the United States (according to the U.S. Census Bureau), of which 68,339 births were to twins and 1,337 births were to triplets or more.

### What was the probability of having multiples (twins or more) in 1980?

### Enter as a percent but do not include the % sign. Round to the nearest tenth (e.g., x.x).


~~~
prob.multip <- (68339 + 1337)/3612258
round(prob.multip * 100, 1)
~~~

~~~
## [1] 1.9
~~~


## Question 2:

### What was the probability of a woman giving birth to multiples twice in a row in the pre-IVF era? (Assume that the probabilities for 1980 are representative of the pre-IVF era.)

### Enter as a percent but do not include the % sign. Round to 3 decimal places (e.g., .xxx).

Assuming that having multiple births is a random event (i.e., women who have had a multiple birth are not more likely to have another multiple birth), we multiply the probability of a multiple birth by itself.

~~~
prob.2.multip <- prob.multip^2
round(prob.2.multip * 100, 3)
~~~

~~~
## [1] 0.037
~~~


## Question 3:

### If a woman had 10 births in her lifetime in the pre-IVF era, what was the chance that at least one of those births was to multiples? (Assume that the probabilities for 1980 are representative of the pre-IVF era.)

### Enter as a percent but do not include the % sign. Round to the nearest tenth (e.g., xx.x). 

The probability of at least one event in a given number of trials is the same as 1 - the probability of no events in that number of trials. The probability of no events in one trial is 1 - the probability of that event happening once. The probability of no events in 10 trials is this to the 10th power.


~~~
prob.no.multip <- (1 - prob.multip)
prob.no.multip.10 <- prob.no.multip^10
prob.at.least.1.multip <- 1 - prob.no.multip.10
round(prob.at.least.1.multip * 100, 1)
~~~

~~~
## [1] 17.7
~~~


## Question 4:

### Suppose that the probability of surviving for 5-years after being diagnosed with a particular cancer is 0.60; and the probability of surviving for 10 years is 0.20. If a person survives 5 years, what is the probability that she will survive 10 years?

### Enter as a percent but do not include the % sign. The answer should be a whole number (e.g. xx). 

If we call event A survival to 5 yrs and event B survival to 10 yrs.

$$ P(A) = 0.6 $$
$$ P(B) = 0.2 $$

We are interested in survival to 10 yrs given survival to 5 yrs. 

$$ P(B|A) = \frac{P(A\&B)}{P(A)} $$

The probability of survival to 5 yrs and survival to 10 yrs is the same thing as survival to 10 yrs, 0.2.

$$ P(B|A) = \frac{0.2}{0.6} $$

~~~
round(0.2/0.6 * 100, 0)
~~~

~~~
## [1] 33
~~~


## Question 5:

### A company has developed a diagnostic test to screen for antibiotic resistance in acne patients. A positive test means that the patient will be less likely to respond to treatment with a specific antibiotic; a negative test means that they will be more likely to respond. To determine the clinical utility of the test, researchers applied the test to 59 patients who were known non-responders to oxytetracycline and 72 patients who were known responders. Here are the results:


~~~
Table5 <- matrix(c(10, 49, 9, 63), nrow = 2)
rownames(Table5) <- c("Test positive", "Test negative")
colnames(Table5) <- c("Non-responders", "Responders")
Table5
~~~

~~~
##               Non-responders Responders
## Test positive             10          9
## Test negative             49         63
~~~


### What is the sensitivity of the test?

### Enter as a percent but do not include the % sign. Round to the nearest whole number.


~~~

q5.sens <- Table5[1, 1]/sum(Table5[, 1])
round(100 * q5.sens, 0)
~~~

~~~
## [1] 17
~~~


## Question 6:

### What is the specificity of the test?

### Enter as a percent but do not include the % sign. Round to the nearest whole number. 


~~~
q6.spec <- Table5[2, 2]/sum(Table5[, 2])
round(100 * q6.spec, 0)
~~~

~~~
## [1] 88
~~~


## Question 7:

### The company believes that the prevalence of oxytetracycline resistance among acne patients in the general population is about 50%. Use this information to calculate the positive predictive value.

### Enter as a percent but do not include the % sign. Round to the nearest whole number. 

We can estimate this using "natural frequencies". Imagine we select 1000 people at random from the population. We can then assume that 50%, or 500 have resistance and 500 do not.

We multiply the 500 with resistance by the test sensitivity to find out how many with the disease will test positive. 

~~~
500 * q5.sens
~~~

~~~
## [1] 84.75
~~~


We multiply the 500 without resistance by the test specificity to find out how many without the disease will test negative.

~~~
500 * q6.spec
~~~

~~~
## [1] 437.5
~~~


 | Resistant | Not Resistant | Total
--- | :---: | :---: | :---:
Test positive | 84.75 |  ? | 
Test negative | ? | 437.5 | 
Total | 500 | 500 | 1000

We can then fill in the question marks by subtacting from 500.


~~~
500 - q5.sens * 500
~~~

~~~
## [1] 415.3
~~~

~~~
500 - q6.spec * 500
~~~

~~~
## [1] 62.5
~~~



 | Resistant | Not Resistant | Total
--- | :---: | :---: | :---:
Test positive | 84.75 |  62.5 | 
Test negative | 415.25 | 437.5 | 
Total | 500 | 500 | 1000

By adding across the rows, we can get the row totals.


~~~
q5.sens * 500 + (500 - q6.spec * 500)
~~~

~~~
## [1] 147.2
~~~

~~~
500 * q6.spec + (500 - q5.sens * 500)
~~~

~~~
## [1] 852.8
~~~


 | Resistant | Not Resistant | Total
--- | :---: | :---: | :---:
Test positive | 84.75 |  62.5 | 147.25
Test negative | 415.25 | 437.5 | 852.75
Total | 500 | 500 | 1000

Positive predictive value can then be easily calculated:


~~~
q5.sens * 500/(q5.sens * 500 + (500 - q6.spec * 500))
~~~

~~~
## [1] 0.5755
~~~

~~~
round(100 * q5.sens * 500/(q5.sens * 500 + (500 - q6.spec * 500)), 0)
~~~

~~~
## [1] 58
~~~


## Question 8:

### The company believes that the prevalence of oxytetracycline resistance among acne patients in the general population is about 50%. Use this information to calculate the negative predictive value.

### Enter as a percent but do not include the % sign. Round to the nearest whole number. 

Using the prior table, we can again calculate the NPV easily.


~~~
round(500 * q6.spec/(500 * q6.spec + (500 - q5.sens * 500)) * 100, 0)
~~~

~~~
## [1] 51
~~~


## Question 9:

### In a blind taste test, three panelists tasted five pizza brands—Godfather's, Papa John's, Pizza Hut, zpizza and Ledo Pizza. All three panelists rated Godfather’s pizza dead last. What’s the probability that this outcome happened purely by chance?

### In other words, assume that there is no taste difference between the five brands sampled and calculate the probability that all three panelists happened to randomly rate Godfather’s as worst.

### Enter as a percent but do not include the % sign. Round to the nearest tenth (e.g., .x). 

Start with calculating the probability that one person ranks it last. There are different ways of thinking about this, but start with the number of possible permutations of 5.


~~~
factorial(5)
~~~

~~~
## [1] 120
~~~


Then we can think about how many of these rearrangements of 5 there are with the last position Godfather's. Essentially, this is the same as thinking about how many rearrangements there are of the remaining 4 pizza places.


~~~
factorial(4)
~~~

~~~
## [1] 24
~~~


So what is the probability that one person would randomly choose Godfather's last? This is the number of ways that it can be last over the total number of permutations.


~~~
factorial(4)/factorial(5)
~~~

~~~
## [1] 0.2
~~~


Now what is the probability that 3 people choose it last, assuming that they are independent?


~~~
(factorial(4)/factorial(5))^3
~~~

~~~
## [1] 0.008
~~~



## Question 10:

### In the early 1980s, hemophiliacs received reconstituted clotting factor concentrates derived from human blood. The concentrates were pooled from the blood of about 1000 donors per lot. If the prevalence of HIV in donor blood in the early 1980s was 1 in 3,000, what was the probability that a hemophiliac would contract HIV from a single infusion of clotting factors?

### Enter as a percent but do not include the % sign. Round to the nearest tenth (e.g., xx.x). 

Restating this problem, what is the probability that at least one of the 1000 donors that make up the pool has HIV?

This is the same as 1 - the probability that none of those 1000 donors has HIV. 


~~~
prob.no.HIV <- 1 - 1/3000
prob.no.HIV^1000  # probablity that none of a sample of 1000 people have HIV
~~~

~~~
## [1] 0.7165
~~~

~~~
1 - prob.no.HIV^1000
~~~

~~~
## [1] 0.2835
~~~

~~~
round(100 * (1 - prob.no.HIV^1000), 1)
~~~

~~~
## [1] 28.4
~~~

