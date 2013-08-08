Incidence Rates, Cumulative Risk, and Prevalence
=====

## Incidence rate

Create table of events and person time.

```r
library(epiR)
```

```
## Loading required package: survival
```

```
## Loading required package: splines
```

```
## Package epiR 0.9-48 is loaded
```

```
## Type help(epi.about) for summary information
```

```
## 
```

```r
Table <- matrix(c(56, 121, 2315, 2316), 2, 2)
Table
```

```
##      [,1] [,2]
## [1,]   56 2315
## [2,]  121 2316
```

```r
Table[1, 1]/Table[1, 2]
```

```
## [1] 0.02419
```


Use `epi.2by2` to calculate incidence estimates.

```r
epi.2by2(Table, method = "cohort.time")
```

```
##              Disease +    Time at risk        Inc rate *
## Exposed +           56            2315              2.42
## Exposed -          121            2316              5.22
## Total              177            4631              3.82
## 
## Point estimates and 95 % CIs:
## ---------------------------------------------------------
## Inc rate ratio                           0.46 (0.33, 0.64)
## Attrib rate *                            -2.81 (-3.93, -1.68)
## Attrib rate in population *              -1.4 (-2.49, -0.31)
## Attrib fraction in exposed (%)           -116 (-202.03, -56.09)
## Attrib fraction in population (%)        -36.69 (-40.97, -32.57)
## ---------------------------------------------------------
##  * Cases per 100 units of population time at risk
```


## Risk 
Create table of events and people. We need to subtract off the events from the second column of subjects to get the totals right.

```r
Table2 <- matrix(c(56, 121, 4047 - 56, 4029 - 121), 2, 2)
Table2
```

```
##      [,1] [,2]
## [1,]   56 3991
## [2,]  121 3908
```

```r
prop.table(Table2, 1)
```

```
##         [,1]   [,2]
## [1,] 0.01384 0.9862
## [2,] 0.03003 0.9700
```


Use `epi.2by2` to calculate incidence estimates.

```r
epi.2by2(Table2, method = "cohort.count")
```

```
##              Disease +    Disease -      Total        Inc risk *
## Exposed +           56         3991       4047              1.38
## Exposed -          121         3908       4029              3.00
## Total              177         7899       8076              2.19
##                  Odds
## Exposed +      0.0140
## Exposed -      0.0310
## Total          0.0224
## 
## Point estimates and 95 % CIs:
## ---------------------------------------------------------
## Inc risk ratio                         0.46 (0.34, 0.63)
## Odds ratio                             0.45 (0.32, 0.63)
## Attrib risk *                          -1.62 (-2.26, -0.98)
## Attrib risk in population *            -0.81 (-1.43, -0.2)
## Attrib fraction in exposed (%)         -117 (-197.03, -58.59)
## Attrib fraction in population (%)      -37.03 (-51.38, -24.04)
## ---------------------------------------------------------
##  * Cases per 100 population units
```


## Cross sectional data

```r
Table3 <- matrix(c(9, 11, 16, 894 - 9, 487 - 11, 539 - 16), 3, 2)
Table3
```

```
##      [,1] [,2]
## [1,]    9  885
## [2,]   11  476
## [3,]   16  523
```

```r
prop.table(Table3, 1)
```

```
##         [,1]   [,2]
## [1,] 0.01007 0.9899
## [2,] 0.02259 0.9774
## [3,] 0.02968 0.9703
```

