Week 3 R Exercise
====

## Introduction
I didn't write any exercises on probability since R doesn't really help you understand probability. However, sensitivity and specificity as well as positive and negative predictive values are relevant medical data analysis questions, particularly when you are trying to come up with a test that can predict a disease state.

If you are given one continuous variable (test result) and one categorical variable (disease status), you can see whether the categorical variable can be predicted from the continuous one. One way to do this is to create a cutoff point for the test. Above a certain value, you can call the result positive and below it negative. You can then see what are the sensitivity, specificity, positive predictive value and negative predictive value when looking at the real result.

There are many examples of this in medical diagnostic testing. The amount of activity of the elastase enzyme in a stool sample can be used to predict whether a patient has cystic fibrosis. However to do so, you have to have a cutoff point (i.e., below a certain level of elastase level, the patient likely has CF). Then you can run a trial to calculate sensitivity, specificity, PPV, and NPV.

## Dataset
I couldn't find a good medical dataset example so for this example we will use the `iris` dataset. This dataset comes preinstalled with most R installations. Use `?iris` to find out more about the data.

## Challenge
For simplicity, we will just look at the iris species *versicolor* and *virginica* and try to tell them apart by how long their petals are. If you want to pretend this is a medical problem, think of *versicolor* status as disease and petal length as a test result.

## Questions
### Q1. Load the `iris` data. What are the 3 kinds of Species in the data? 

First we load the data.


```r
data(iris)
```


Looking at the `Species` variable, we see there are three types:


```r
summary(iris$Species)
```

```
##     setosa versicolor  virginica 
##         50         50         50
```


### Q2. Subset the data by removing the *setosa* species, keeping only *versicolor* and *virginica* species. Save the resulting subset in a new data frame.

Subset out the *setosa* species, saving the result into a new dataframe called `irisvv`.


```r
irisvv <- subset(iris, subset = iris$Species != "setosa")
```


### Q3. Create a boxplot comparing the petal lengths of the two species (i.e., boxplot of petal length by species).


```r
boxplot(Petal.Length ~ Species, data = irisvv)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


To get rid of the factor label of *setosa* in the plot, we can just run the `factor` function on `Species` again. Unused levels will be dropped. Then make the boxplot again.


```r
irisvv$Species <- factor(irisvv$Species)
boxplot(Petal.Length ~ Species, data = irisvv)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


### Q4. Recode the `Petal.Length` variable into a new binomial variable depending on whether the petal length is >= 5 or < 5.


```r
irisvv$shortpetal <- ifelse(irisvv$Petal.Length < 5, 1, 0)
irisvv$shortpetal <- factor(irisvv$shortpetal, levels = 1:0, labels = c("<5 cm", 
    ">=5 cm"))
table(irisvv$shortpetal)
```

```
## 
##  <5 cm >=5 cm 
##     54     46
```


### Q5. Create a 2x2 table with the new variable as the rows and the species on the columns.


```r
Table <- with(irisvv, table(shortpetal, Species))
Table
```

```
##           Species
## shortpetal versicolor virginica
##     <5 cm          48         6
##     >=5 cm          2        44
```


### Q6. Calculate the sensitivity of your test for diagnosing an iris as `versicolor` in this dataset. What is the specificity? Positive predictive value? Negative predictive value?

Sensitivity

```r
Table[1, 1]/sum(Table[, 1])
```

```
## [1] 0.96
```


Specificity

```r
Table[2, 2]/sum(Table[, 2])
```

```
## [1] 0.88
```


PPV

```r
Table[1, 1]/sum(Table[1, ])
```

```
## [1] 0.8889
```


NPV

```r
Table[2, 2]/sum(Table[2, ])
```

```
## [1] 0.9565
```


### Note on PPV and NPV
I didn't specify how common *versicolor* and *virginica* irises are in the world (i.e., what is the prevalence of *versicolor* irises), which is important to know for PPV and NPV. In this example there are an equal number of *versicolor* and *virginica* (i.e., prevalance of *versicolor* = 0.50). The results for PPV and NPV will change depending on the actual frequency of *versicolor* and *virginica* irises.

----

Or we can just make up our data

```r
set.seed(90025)
W3data <- data.frame(test = c(rnorm(1000, mean = 10, sd = 1), rnorm(1000, mean = 8, 
    sd = 1)), disease = c(rep(1, 1000), rep(0, 1000)))
W3data$test2 <- ifelse(W3data$test < 9, 0, 1)
W3data$test2 <- factor(W3data$test2, levels = 0:1, labels = c("Test pos", "Test neg"))
W3data$disease <- factor(W3data$disease, levels = 0:1, labels = c("Disease pos", 
    "Disease neg"))
Table <- with(W3data, table(test2, disease))
Table
```

```
##           disease
## test2      Disease pos Disease neg
##   Test pos         842         177
##   Test neg         158         823
```

```r
boxplot(test ~ disease, data = W3data, ylab = "Test result")
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 


Sensitivity

```r
Table[1, 1]/sum(Table[, 1])
```

```
## [1] 0.842
```


Specificity

```r
Table[2, 2]/sum(Table[, 2])
```

```
## [1] 0.823
```


PPV

```r
Table[1, 1]/sum(Table[1, ])
```

```
## [1] 0.8263
```


NPV

```r
Table[2, 2]/sum(Table[2, ])
```

```
## [1] 0.8389
```


### What happens if we change the cutoff? Can you create a function that will display the change in sensitivity and specificity depending on where the cutoff is?


```r
results <- data.frame(sensitivity = rep(NA, 100), specificity = rep(NA, 100), 
    PPV = rep(NA, 100), NPV = rep(NA, 100))

irisvv.ordered <- irisvv[order(irisvv$Petal.Length), ]

results$Petal.Length <- irisvv.ordered$Petal.Length

for (i in seq_along(irisvv.ordered$Petal.Length)) {
    cutoff <- irisvv.ordered$Petal.Length[i]
    irisvv.ordered$shortpetal <- ifelse(irisvv.ordered$Petal.Length < cutoff, 
        1, 0)
    irisvv.ordered$shortpetal <- factor(irisvv.ordered$shortpetal, levels = 1:0, 
        labels = c("<5 cm", ">5 cm"))
    Table <- with(irisvv.ordered, table(shortpetal, Species))
    results[i, 1] <- Table[1, 1]/sum(Table[, 1])  # sens
    results[i, 2] <- Table[2, 2]/sum(Table[, 2])  # spec
    results[i, 3] <- Table[1, 1]/sum(Table[1, ])  # PPV
    results[i, 4] <- Table[2, 2]/sum(Table[2, ])  # NPV
}

results
```

```
##     sensitivity specificity    PPV    NPV Petal.Length
## 1          0.00        1.00    NaN 0.5000          3.0
## 2          0.02        1.00 1.0000 0.5051          3.3
## 3          0.02        1.00 1.0000 0.5051          3.3
## 4          0.06        1.00 1.0000 0.5155          3.5
## 5          0.06        1.00 1.0000 0.5155          3.5
## 6          0.10        1.00 1.0000 0.5263          3.6
## 7          0.12        1.00 1.0000 0.5319          3.7
## 8          0.14        1.00 1.0000 0.5376          3.8
## 9          0.16        1.00 1.0000 0.5435          3.9
## 10         0.16        1.00 1.0000 0.5435          3.9
## 11         0.16        1.00 1.0000 0.5435          3.9
## 12         0.22        1.00 1.0000 0.5618          4.0
## 13         0.22        1.00 1.0000 0.5618          4.0
## 14         0.22        1.00 1.0000 0.5618          4.0
## 15         0.22        1.00 1.0000 0.5618          4.0
## 16         0.22        1.00 1.0000 0.5618          4.0
## 17         0.32        1.00 1.0000 0.5952          4.1
## 18         0.32        1.00 1.0000 0.5952          4.1
## 19         0.32        1.00 1.0000 0.5952          4.1
## 20         0.38        1.00 1.0000 0.6173          4.2
## 21         0.38        1.00 1.0000 0.6173          4.2
## 22         0.38        1.00 1.0000 0.6173          4.2
## 23         0.38        1.00 1.0000 0.6173          4.2
## 24         0.46        1.00 1.0000 0.6494          4.3
## 25         0.46        1.00 1.0000 0.6494          4.3
## 26         0.50        1.00 1.0000 0.6667          4.4
## 27         0.50        1.00 1.0000 0.6667          4.4
## 28         0.50        1.00 1.0000 0.6667          4.4
## 29         0.50        1.00 1.0000 0.6667          4.4
## 30         0.58        1.00 1.0000 0.7042          4.5
## 31         0.58        1.00 1.0000 0.7042          4.5
## 32         0.58        1.00 1.0000 0.7042          4.5
## 33         0.58        1.00 1.0000 0.7042          4.5
## 34         0.58        1.00 1.0000 0.7042          4.5
## 35         0.58        1.00 1.0000 0.7042          4.5
## 36         0.58        1.00 1.0000 0.7042          4.5
## 37         0.58        1.00 1.0000 0.7042          4.5
## 38         0.72        0.98 0.9730 0.7778          4.6
## 39         0.72        0.98 0.9730 0.7778          4.6
## 40         0.72        0.98 0.9730 0.7778          4.6
## 41         0.78        0.98 0.9750 0.8167          4.7
## 42         0.78        0.98 0.9750 0.8167          4.7
## 43         0.78        0.98 0.9750 0.8167          4.7
## 44         0.78        0.98 0.9750 0.8167          4.7
## 45         0.78        0.98 0.9750 0.8167          4.7
## 46         0.88        0.98 0.9778 0.8909          4.8
## 47         0.88        0.98 0.9778 0.8909          4.8
## 48         0.88        0.98 0.9778 0.8909          4.8
## 49         0.88        0.98 0.9778 0.8909          4.8
## 50         0.92        0.94 0.9388 0.9216          4.9
## 51         0.92        0.94 0.9388 0.9216          4.9
## 52         0.92        0.94 0.9388 0.9216          4.9
## 53         0.92        0.94 0.9388 0.9216          4.9
## 54         0.92        0.94 0.9388 0.9216          4.9
## 55         0.96        0.88 0.8889 0.9565          5.0
## 56         0.96        0.88 0.8889 0.9565          5.0
## 57         0.96        0.88 0.8889 0.9565          5.0
## 58         0.96        0.88 0.8889 0.9565          5.0
## 59         0.98        0.82 0.8448 0.9762          5.1
## 60         0.98        0.82 0.8448 0.9762          5.1
## 61         0.98        0.82 0.8448 0.9762          5.1
## 62         0.98        0.82 0.8448 0.9762          5.1
## 63         0.98        0.82 0.8448 0.9762          5.1
## 64         0.98        0.82 0.8448 0.9762          5.1
## 65         0.98        0.82 0.8448 0.9762          5.1
## 66         0.98        0.82 0.8448 0.9762          5.1
## 67         1.00        0.68 0.7576 1.0000          5.2
## 68         1.00        0.68 0.7576 1.0000          5.2
## 69         1.00        0.64 0.7353 1.0000          5.3
## 70         1.00        0.64 0.7353 1.0000          5.3
## 71         1.00        0.60 0.7143 1.0000          5.4
## 72         1.00        0.60 0.7143 1.0000          5.4
## 73         1.00        0.56 0.6944 1.0000          5.5
## 74         1.00        0.56 0.6944 1.0000          5.5
## 75         1.00        0.56 0.6944 1.0000          5.5
## 76         1.00        0.50 0.6667 1.0000          5.6
## 77         1.00        0.50 0.6667 1.0000          5.6
## 78         1.00        0.50 0.6667 1.0000          5.6
## 79         1.00        0.50 0.6667 1.0000          5.6
## 80         1.00        0.50 0.6667 1.0000          5.6
## 81         1.00        0.50 0.6667 1.0000          5.6
## 82         1.00        0.38 0.6173 1.0000          5.7
## 83         1.00        0.38 0.6173 1.0000          5.7
## 84         1.00        0.38 0.6173 1.0000          5.7
## 85         1.00        0.32 0.5952 1.0000          5.8
## 86         1.00        0.32 0.5952 1.0000          5.8
## 87         1.00        0.32 0.5952 1.0000          5.8
## 88         1.00        0.26 0.5747 1.0000          5.9
## 89         1.00        0.26 0.5747 1.0000          5.9
## 90         1.00        0.22 0.5618 1.0000          6.0
## 91         1.00        0.22 0.5618 1.0000          6.0
## 92         1.00        0.18 0.5495 1.0000          6.1
## 93         1.00        0.18 0.5495 1.0000          6.1
## 94         1.00        0.18 0.5495 1.0000          6.1
## 95         1.00        0.12 0.5319 1.0000          6.3
## 96         1.00        0.10 0.5263 1.0000          6.4
## 97         1.00        0.08 0.5208 1.0000          6.6
## 98         1.00        0.06 0.5155 1.0000          6.7
## 99         1.00        0.06 0.5155 1.0000          6.7
## 100        1.00        0.02 0.5051 1.0000          6.9
```

```r

plot(1 - results$specificity, results$sensitivity)
```

![plot of chunk unnamed-chunk-17](figure/unnamed-chunk-17.png) 


-----

Or we can just make up our data

```r
set.seed(90025)
W3data <- data.frame(test = c(rnorm(1000, mean = 10, sd = 1), rnorm(1000, mean = 8, 
    sd = 1)), disease = c(rep(1, 1000), rep(0, 1000)))
W3data$test2 <- ifelse(W3data$test < 9, 0, 1)
W3data$test2 <- factor(W3data$test2, levels = 0:1, labels = c("Test pos", "Test neg"))
W3data$disease <- factor(W3data$disease, levels = 0:1, labels = c("Disease pos", 
    "Disease neg"))
Table <- with(W3data, table(test2, disease))
Table
```

```
##           disease
## test2      Disease pos Disease neg
##   Test pos         842         177
##   Test neg         158         823
```

```r
boxplot(test ~ disease, data = W3data, ylab = "Test result")
```

![plot of chunk unnamed-chunk-18](figure/unnamed-chunk-18.png) 


Sensitivity

```r
Table[1, 1]/sum(Table[, 1])
```

```
## [1] 0.842
```


Specificity

```r
Table[2, 2]/sum(Table[, 2])
```

```
## [1] 0.823
```


PPV

```r
Table[1, 1]/sum(Table[1, ])
```

```
## [1] 0.8263
```


NPV

```r
Table[2, 2]/sum(Table[2, ])
```

```
## [1] 0.8389
```

