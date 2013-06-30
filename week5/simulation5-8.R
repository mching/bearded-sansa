x <- rep(NA, 15000)
set.seed(96859)
for(i in 1:15000) {
  x[i] <- 2*(62.5 - sum(rbinom(125, 1, prob = 0.5)))
}
mean(x)
sd(x)
hist(x)
sum(abs(x)>=23)/15000


pbinom(51, 125, 0.5) # one sided
2 * pbinom(51, 125, 0.5) # two sided
