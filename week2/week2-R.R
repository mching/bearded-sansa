# Unit 2 examples

# load rats dataset from survival package
library(survival)
data(rats)

str(rats)
rats$status.factor <- factor(rats$status, levels = 1:0, labels = c("tumor", "censored"))
rats$rx.factor <- factor(rats$rx, levels = 1:0, labels = c("drug", "control"))

Table1 <- with(rats, table(rx.factor, status.factor))
Table1

# Calculate risks and risk ratio
epi.2by2(Table1)

# How much person time is accumulated in the drug group? 
person.time <- tapply(rats$time, rats$rx.factor, sum)
person.time

# Construct person-time table
Table2 <- matrix(NA, 2, 2)
Table2[, 1] <- Table1[, 1]
Table2[, 2] <- person.time
rownames(Table2) <- c("drug", "control")
colnames(Table2) <- c("tumor", "person-time")
Table2

# Calculate rates and rate ratio
epi.2by2(Table2, method="cohort.time")