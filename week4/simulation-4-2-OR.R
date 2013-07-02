# Simulate OR
# Lecture 4-2 HRP 258

# Generate sample data
# n = 1000 cases and n = 1000 controls
# 20% cases are smokers and 20% controls are smokers

dat <- data.frame(disease = rep(0:1, c(1000,1000)), smoker = rep(c(1,0,0,0,0), 400))
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
  cases.index <- sample(1000, 50, replace = F)
  controls.index <- sample(1000, 50, replace = F) + 1000L
  Table <- table(dat[c(cases.index, controls.index), ])

  # Calculate OR and store
  OR.data[i] <- Table[1, 1] * Table[2, 2] / Table[1, 2] / Table[2, 1]
}

mean(OR.data)
sd(OR.data)