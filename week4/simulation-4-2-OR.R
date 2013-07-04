# Simulate OR
# Lecture 4-2 HRP 258

# Generate sample data
# n = 1000 cases and n = 1000 controls
# 20% cases are smokers and 20% controls are smokers

dat <- data.frame(disease = rep(0:1, c(10000,10000)), smoker = rep(c(1,0,0,0,0), 4000))
dat$disease <- factor(dat$disease, levels = 1:0, labels = c("case", "control"))
dat$smoker <- factor(dat$smoker, levels = 1:0, labels = c("smoker", "non-smoker"))
table(dat)

# Make variable to store results
OR.data <- rep(NA, 1000)

# Set seed
set.seed(2467)

# Simulation
for(i in 1:1000) {
  # Sample 50 cases and 50 controls
  cases.index <- sample(10000, 50, replace = F)
  controls.index <- sample(10000, 50, replace = F) + 10000L
  Table <- table(dat[c(cases.index, controls.index), ])

  # Calculate OR and store
  OR.data[i] <- Table[1, 1] * Table[2, 2] / Table[1, 2] / Table[2, 1]
}

summary(OR.data)
hist(OR.data)
hist(log(OR.data))
mean(OR.data[OR.data < Inf])
sd(OR.data[OR.data < Inf])

##################

# Method 2, binomial method

set.seed(2115)

OR.data2 <- rep(NA, 1000)

for(i in 1:1000) {
  cases <- rbinom(50, 1, 0.2)
  controls <- rbinom(50, 1, 0.2)
  sum(cases) # Number of cases exposed to smoking
  sum(controls) # Number of controls exposed to smoking
  # Odds of smoking in cases over odds of smoking in controls
  OR.data2[i] <- (sum(cases) / (50 - sum(cases))) / (sum(controls) / (50 - sum(controls)))
}

summary(OR.data2)
hist(OR.data2)
hist(log(OR.data2))

mean(OR.data2)
sd(OR.data2)