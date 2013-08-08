Unit 3 Module 4 Quiz
====

### Given:
$$ P(B) = 0.75 $$
$$ P(A) = 0.20 $$
$$ P(A\&B) = 0.10 $$
### What is $P(A|B)?$?

We can use Boyle's Theorem to figure this out.
$$ P(A|B) = \frac{P(B | A)\, P(A)}{P(B)} $$

We have to derive $P(B | A)$.

$$ P(B | A) = \frac{P(A \& B)}{P(A)} $$
$$ P(B | A) = \frac{0.10}{0.20} = 0.5 $$

We can then use this conditional probability in Boyle's Theorem.

$$ P(A|B) = \frac{P(B | A)\, P(A)}{P(B)} $$
$$ P(A|B) = \frac{0.5 * 0.2}{0.75}$$


```r
0.5 * 0.2/0.75
```

```
## [1] 0.1333
```

