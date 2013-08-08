Week 7 R
=====
### Survival Analysis in R

R comes preinstalled with the `survival` package to do survival analysis.

```r
library(survival)
```

```
## Loading required package: splines
```


We can return to the `rats` dataset from our week 2 example to see how this works.

```r
data(rats)
```


We first have to create a survival object by combining time and the event (censored or failure/tumor).

```r
surv.object <- Surv(time = rats$time, event = rats$status)
```


The time are labeled by + signs for censored observations.

```r
surv.object
```

```
##   [1] 101+  49  104+ 104+ 102+ 104+ 104+ 104+ 104+  77+  97+  79+  89+ 104+
##  [15] 104+  88   96  104+ 104   94+  77   96  104+ 104+  82+  77+ 104+  70 
##  [29] 104+  77+  89   91+  90+  91+  70+  92+  39   45+  50  103   69+  91+
##  [43]  93+ 104+ 103+  85+  72+ 104+ 104+  63+ 104+ 104+ 104+  74+  81+ 104+
##  [57]  69+  67  104+  68  104+ 104+ 104+ 104+ 104+ 104+ 104+  83+  40   87+
##  [71] 104+ 104+ 104+ 104+ 104+  89+ 104+ 104+  78+ 104+ 104+ 104+  81   64 
##  [85]  86   55   94+  34  104+  54   76+  87+  74+ 103   73   84  102  104+
##  [99]  80+  80  104+  73+  45   79+ 104+  94  104+ 104+ 104+ 104+ 104+ 104+
## [113] 101   94+  76+  84   78   80   81   76+  72   95+ 104+  73  104+  66 
## [127]  92  104+ 102  104+  98+  73+  55+ 104+ 104+  49+  83+  77+  89  104+
## [141] 104+  88+  79+  99+ 103   91+ 104+ 104+ 104+  79
```


We then fit a survival curve to it using `survfit`. As you can see, that's not so interesting, so we can plot it to see the actual curve.

```r
survfit(surv.object ~ 1)
```

```
## Call: survfit(formula = surv.object ~ 1)
## 
## records   n.max n.start  events  median 0.95LCL 0.95UCL 
##     150     150     150      40      NA      NA      NA
```

```r
plot(survfit(surv.object ~ 1))
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


To compare two curves by group, we can replace the 1 in the formula above by the group variable, in this case, treatment.

```r
surv.all <- survfit(surv.object ~ rats$rx)
plot(surv.all, col = c("red", "blue"), xlab = "time", ylab = "percent survival")
legend(x = "bottomleft", legend = "Red = control, Blue = drug")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


The curves look divergent but to test the null hypothesis that they are the same, we can use the log rank test. This is done using the `survdiff` function.

```r
survdiff(surv.object ~ rats$rx)
```

```
## Call:
## survdiff(formula = surv.object ~ rats$rx)
## 
##             N Observed Expected (O-E)^2/E (O-E)^2/V
## rats$rx=0 100       19     27.5      2.65      8.61
## rats$rx=1  50       21     12.5      5.87      8.61
## 
##  Chisq= 8.6  on 1 degrees of freedom, p= 0.00335
```


### Problems

1. Load the National Wilms Tumor dataset (`data(nwtco)`) from the survival package.
2. Create the survey object using `rel` (relapse) as the event and `edrel` (time to relapse) as the time.
3. Fit the survival curve and plot it.
4. Compare time to relapse by the tumor pathology reported by the local institution (variable name is `instit`). Plot the survival curve by local institution tumor pathology.
5. Test the null hypothesis that the two survival curves for both pathology types are equal.
