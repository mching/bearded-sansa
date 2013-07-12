set.seed(96859)
x <- 125 - 2 * rbinom(15000, 125, 0.5)
mean(x)
sd(x)
hist(x)
sum(abs(x)>=23)/15000

pbinom(51, 125, 0.5) # one sided
2 * pbinom(51, 125, 0.5) # two sided
