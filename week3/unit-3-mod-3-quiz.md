Unit 3 Mod 3 Quiz
====

### Suppose that 15% of the population was exposed to a dangerous chemical Z. If people who were not exposed to Z have a lifetime risk of pancreatic cancer of .0001 and people who were exposed to Z have a lifetime risk of .0004, what percent of the population will develop pancreatic cancer (e.g., what is the marginal probability of pancreatic cancer)?  

Use the law of total probability.
$$P(A) = P(A|B)*P(B) + P(A|\sim B)*P(\sim B)$$

$$P(cancer) = P(cancer|exposed)*P(exposed) + P(cancer|not.exposed)*P(not.exposed)$$

$$P(cancer) = 0.0004*0.15 + 0.0001*(1-0.15)$$


```r
4e-04 * 0.15 + 1e-04 * (1 - 0.15)
```

```
## [1] 0.000145
```


### Suppose that 15% of the population was exposed to a dangerous chemical Z. People who were not exposed to Z have a lifetime risk of pancreatic cancer of .0001 and people who were exposed to Z have a lifetime risk of .0004. If someone develops pancreatic cancer, what is the chance that he/she was exposed to Z?

$$ P(A|B) = \frac{P(B | A)\, P(A)}{P(B)} $$
$$ P(exposed|cancer) = \frac{P(cancer | exposed)\, P(exposed)}{P(cancer)} $$
$$ P(exposed|cancer) = \frac{(0.0004)(0.15)}{0.000145} $$


```r
4e-04 * 0.15/0.000145
```

```
## [1] 0.4138
```

