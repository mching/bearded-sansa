MOOC: R Exercise 3
====


```r
# download.file(url =
# 'https://s3-us-west-1.amazonaws.com/prod-edx/MedStats/RegressionExerciseDocs/mock_class_data.csv',
# destfile = 'mock_class_data.csv', method = 'curl')
dat <- read.csv("./mock_class_data.csv")
```


1. What is the Pearson correlation coefficient between the variables ‘politics’ and ‘obama’? What does the p-value of the correlation coefficient suggest about its significance? Draw a scatter plot to visually verify the sign and magnitude of r.


```r
cor(dat$politics, dat$obama, method = "pearson", use = "complete.obs")
```

```
## [1] 0.7789
```

```r
plot(dat$politics, dat$obama)
abline(lm(obama ~ politics, data = dat), col = "red")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


2. What is the Pearson correlation coefficient between the variables ‘Mathlove’ and ‘Writinglove’? Is the correlation coefficient significant? 


```r
cor.test(dat$Mathlove, dat$WritingLove, method = "pearson", use = "complete.obs")
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  dat$Mathlove and dat$WritingLove
## t = 0.8618, df = 43, p-value = 0.3936
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.1697  0.4082
## sample estimates:
##    cor 
## 0.1303
```


3. Pearson's correlation coefficient assumes that both variables are normally distributed (an assumption that's especially important for small samples). In the two questions above, was this assumption ever violated? 


```r
hist(dat$Mathlove)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-41.png) 

```r
qqnorm(dat$Mathlove)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-42.png) 

```r
hist(dat$WritingLove)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-43.png) 

```r
qqnorm(dat$WritingLove)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-44.png) 

Writing love looks to be bimodal, not normally distributed.

4. Perform a linear regression of President Obama’s approval scores (‘obama’) vs. students’ impression of the new health care reform law (‘healthcare’). What are the values for the beta and the intercept? Are both of them statistically significant? What is the value of R2 for this linear regression?


```r
model4 <- lm(obama ~ healthcare, data = dat)
summary(model4)
```

```
## 
## Call:
## lm(formula = obama ~ healthcare, data = dat)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -30.249  -7.388   0.658  10.544  23.112 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   55.248      8.026    6.88  1.5e-08 ***
## healthcare     0.318      0.111    2.86   0.0063 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 13.7 on 45 degrees of freedom
##   (9 observations deleted due to missingness)
## Multiple R-squared:  0.154,	Adjusted R-squared:  0.135 
## F-statistic:  8.2 on 1 and 45 DF,  p-value: 0.00633
```


5. Next, perform another linear regression of President Obama’s approval scores on the students’ political bent AND their impression of the new health care reform law. What are the values for the betas and intercept? Compare the R2 value for this regression with the R2 values you obtained for the previous question. Is there any evidence of confounding?


```r
model5 <- lm(obama ~ healthcare + politics, data = dat)
summary(model5)
```

```
## 
## Call:
## lm(formula = obama ~ healthcare + politics, data = dat)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -27.423  -5.052  -0.614   7.355  16.160 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  22.1981     7.0163    3.16   0.0029 ** 
## healthcare    0.1345     0.0797    1.69   0.0989 .  
## politics      0.6250     0.0847    7.38  3.6e-09 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 9.28 on 43 degrees of freedom
##   (10 observations deleted due to missingness)
## Multiple R-squared:  0.63,	Adjusted R-squared:  0.612 
## F-statistic: 36.5 on 2 and 43 DF,  p-value: 5.35e-10
```

R2 went up.

There is confounding of the association by politics. The association between healthcare opinion and obama rating is no longer statistically significant.

6. As an exercise in dummy coding, find the parameters for the following linear regression model:

$Exercise = Intercept + [Varsity \,{} Sport \,{} in \,{} High \,{} School \,{} (1\,{} if\,{} yes)] + Beta$


```r
dat$Varsity.factor <- factor(dat$Varsity, levels = 0:1, labels = c("No", "Yes"))
model6 <- lm(exercise ~ Varsity.factor, data = dat)
summary(model6)
```

```
## 
## Call:
## lm(formula = exercise ~ Varsity.factor, data = dat)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.550 -1.575 -0.575  1.450  7.450 
## 
## Coefficients:
##                   Estimate Std. Error t value Pr(>|t|)    
## (Intercept)          3.575      0.617    5.80  5.1e-07 ***
## Varsity.factorYes    0.975      0.796    1.22     0.23    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.76 on 48 degrees of freedom
##   (6 observations deleted due to missingness)
## Multiple R-squared:  0.0303,	Adjusted R-squared:  0.0101 
## F-statistic:  1.5 on 1 and 48 DF,  p-value: 0.227
```

