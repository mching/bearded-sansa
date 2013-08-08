Week 5 R
====

Part 1: Simulation of Probability Distributions Using R
------
There has been some interest on the discussion forums in making simulations for the concepts we have been learning. 

R can simulate many kinds of random data that will follow a given distribution (normal, t, binomial, Poisson). Typically you can feed into the `rfoo` function the appropriate parameters for the `foo` distribution. 

For example, `rbinom` requires the number of observations, number of trials, and the probability. In this example, we are simulating 1 flip of a coin, and we are doing it 10 times. We can optionally set a "seed" so the pseudo-random number generator comes up with the same result every time.


~~~
set.seed(123)
rbinom(n = 10, size = 1, prob = 0.5)
~~~

~~~
##  [1] 0 1 0 1 1 0 1 1 1 0
~~~


Another example using normally distributed data uses `rnorm`. This requires the inputs of number of observations, mean, and standard deviation. In this example, we want 10 numbers randomly generated from a distribution with mean of 5 and sd of 1.


~~~
set.seed(215)
x <- rnorm(n = 10, mean = 5, sd = 1)
x
~~~

~~~
##  [1] 5.337 3.955 6.471 6.509 4.219 5.396 5.871 3.273 4.358 4.249
~~~


To generate more than one sample, we would most easily do it with a `for` loop. In R, `for` loops are not too complicated.


~~~
for (i in 1:5) {
    print("Hello world")
}
~~~

~~~
## [1] "Hello world"
## [1] "Hello world"
## [1] "Hello world"
## [1] "Hello world"
## [1] "Hello world"
~~~


To extend this to the normal distribution, we can do the following. We need to set up some way to save our result every time, so we need to do this beforehand.


~~~
set.seed(215)

# Set up the vector means as an empty vector with 100 NAs
means <- rep(NA, 100)

# 100 steps in this for loop
for (i in 1:100) {
    
    # Generate the random numbers
    randoms <- rnorm(n = 10, mean = 5, sd = 1)
    
    # Calculate their mean and store it in x[i]. This can be combined with the
    # prior step.
    means[i] <- mean(randoms)
}
~~~

Now we can see what's in `means` and what is its mean and standard deviation.


~~~
means
~~~

~~~
##   [1] 4.964 5.377 4.770 4.934 5.462 5.475 4.588 4.817 4.742 5.068 5.228
##  [12] 5.051 5.184 4.843 4.915 5.194 4.685 4.782 4.844 4.913 4.884 4.612
##  [23] 5.137 5.139 5.144 4.833 5.090 4.586 5.369 4.972 5.165 4.946 5.132
##  [34] 5.159 5.281 5.078 5.327 5.216 4.797 4.786 4.972 4.552 4.676 4.716
##  [45] 5.151 5.365 4.927 5.151 4.976 4.926 5.307 4.830 4.465 5.464 5.627
##  [56] 5.687 4.965 5.081 5.377 5.248 4.874 4.621 5.105 5.107 5.058 4.651
##  [67] 5.134 4.937 4.836 4.970 5.244 5.096 5.189 4.581 4.672 5.648 5.078
##  [78] 5.443 5.123 4.541 5.234 4.952 5.080 4.653 5.356 5.133 5.464 4.826
##  [89] 4.882 4.978 4.958 4.805 4.563 5.346 4.339 5.011 4.695 5.064 4.930
## [100] 5.078
~~~

~~~
mean(means)
~~~

~~~
## [1] 5.012
~~~

~~~
sd(means)  # This is the standard error of the mean, predicted to be 1 divided by the square root of 10
~~~

~~~
## [1] 0.2763
~~~


### Part 1 Problems

1. Simulate flipping 20 coins 10 times. Set seed as `set.seed(100)`.
2. Simulate rolling a die 100 times. Assuming rolling a 6 is a success, how many of those times did you roll a 6? Set seed as `set.seed(101)`
3. You have 10 dice in a cup. You roll the dice and count how many 6s you get. You repeat this 100 times. How many times did you roll a 6 on each trial? On how many of the trials did you roll no sixes? Set seed as `set.seed(105)`
4. Simulate the blood pressures of 20 individuals randomly drawn from a population with a mean blood pressure 120 and standard deviation of 10. What is the mean and standard deviation of the sample? Set seed as `set.seed(142)`.
5. Simulate the mean blood pressures of 1000 samples of 20 individuals drawn from the same population. What is the mean of the sample means? What is the standard deviation of the sample means? What is the theoretical standard error of the mean? How many of the sample means in this example are more than two s.e.m. from the population mean? Set seed as `set.seed(224)`

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


### Part 2 Problems
1. What is the odds ratio?  
2. What is the standard error of the natural log of the odds ratio?  
3. What is the 95% confidence interval for the natural log of the odds ratio?  
4. What is the 95% confidence interval for the odds ratio?  
5. Install the package `epitools` (`install.packages("epitools")`) and use its `oddsratio` function to calculate the odds ratio. Type `?oddsratio` for help in using the function. Compare your result to Q1 and Q4.

