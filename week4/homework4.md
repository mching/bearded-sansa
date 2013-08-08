Homework 4
========================================================

### Question 1:

 The following table shows a discrete probability distribution.
x | p(x)
---|---
0|  0
1|	.1
2|	.2
3|	.4
4|	.1
5|	.2

 Find the expected value (mean) of this probability distribution. Please round to 1 decimal place.


```r
x <- 0:5
px <- c(0, 0.1, 0.2, 0.4, 0.1, 0.2)
ev.x <- sum(x * px)
ev.x
```

```
## [1] 3.1
```


### Question 2:

 The following table shows a discrete probability distribution.
x | p(x)
---|---
0|  0
1|	.1
2|	.2
3|	.4
4|	.1
5|	.2

 Find the standard deviation. Please round to 2 decimal places. 


```r
varx <- sum((x - ev.x)^2 * px)
varx^0.5
```

```
## [1] 1.221
```


### Question 3:

 If spine bone density is normally distributed in young women with a mean of 1.0 g/cm2 and a standard deviation of .10 g/cm2, then how many young women out of 100 would you expect to have bone densities less than .85 g/cm2?

 Round to the nearest whole number.


```r
mean3 <- 1
sd3 <- 0.1
100 * pnorm(0.85, mean = mean3, sd = sd3)
```

```
## [1] 6.681
```


### Question 4:

 If spine bone density is normally distributed in young women with a mean of 1.0 g/cm2 and a standard deviation of .10 g/cm2, then how many young women out of 100 would you expect to have bone densities greater than 1.15 g/cm2?

 Round to the nearest whole number.


```r
100 * pnorm(1.15, mean = mean3, sd = sd3, lower.tail = F)
```

```
## [1] 6.681
```


### Question 5:

If the relative frequency of boys among newborn children in the USA is .513, what’s the probability that exactly 4 of the next 5 births will be boys?

Answer as a percentage and round to the nearest tenth but do not include the % sign.


```r
p5 <- 0.513
dbinom(4, 5, p5)
```

```
## [1] 0.1686
```


### Question 6:

 On a midterm exam, a particular class ended up with a mean raw score of 80 with a standard deviation of 10. The distribution of grades in the class was approximately normal. If the teacher wants to give A’s to the top 25th percentile (top 25%) of the class, what is the lowest raw score you could get and still get an A on the exam? (Hint: go backwards from the probability to the Z score.)

 Round your answer to the nearest hundredth.


```r
mean6 <- 80
sd6 <- 10
qnorm(p = 0.75, mean = mean6, sd = sd6)
```

```
## [1] 86.74
```


### Question 7:

 A doctor performs 8 operations in a given day. Assume that the operations are independent, and each operation is a success with probability 0.95.What’s the probability that the doctor has exactly two failed operations on any given day? Calculate the exact binomial probability (do not use the normal approximation).

 Please answer as a percentage and round your answer to the nearest tenth, but do not include the % sign.


```r
p7 <- 0.95
dbinom(2, 8, p = 1 - p7)
```

```
## [1] 0.05146
```


### Question 8:

 A doctor performs 8 operations in a given day. Assume that the operations are independent, and each operation is a success with probability 0.95. What’s the probability that the doctor has two or more failed operations on any given day? Calculate the exact binomial probabilities (do not use the normal approximation).

 Please answer as a percentage and round your answer to the nearest tenth (do not include the % sign). 


```r
pbinom(1, 8, 1 - p7, lower.tail = F)
```

```
## [1] 0.05724
```


### Question 9:

 You are playing a game that consists of rolling 4 dice at a time. You win the game if you roll at least 3 sixes. You have to pay $50 to play each round, but you win $1,000,000 if you win. TRUE or FALSE, the expected value of this game is negative.


```r
p9 <- pbinom(2, 4, 1/6, lower.tail = F)
10^6 * p9
```

```
## [1] 16204
```

```r
10^6 * p9 - 50  # EV
```

```
## [1] 16154
```


### Question 10:

 In a randomized trial, 200 subjects were to be randomly assigned either to the drug treatment group or to the placebo group. Researchers flipped a coin to decide each participant’s treatment assignment. After randomization, 112 subjects were in the treatment group and 88 were in the control group. What’s the probability that 112 or more subjects could end up in the treatment group purely by chance? Hint: use a normal approximation to the binomial.

 Please answer as a percentage and round your answer to the nearest hundredth. Do not include the % sign.


```r
n10 <- 200
p10 <- 0.5
q10 <- 1 - p10
mean10 <- n10 * p10
var10 <- n10 * p10 * q10
sd10 <- var10^0.5
mean10
```

```
## [1] 100
```

```r
sd10
```

```
## [1] 7.071
```

```r

1 - pnorm(112, mean10, sd10)
```

```
## [1] 0.04484
```

```r
pnorm(112, mean10, sd10, lower.tail = F)
```

```
## [1] 0.04484
```

```r

pnorm(111.5, mean10, sd10, lower.tail = F)
```

```
## [1] 0.05194
```

```r
pbinom(111, 200, 0.5, lower.tail = F)
```

```
## [1] 0.05182
```


