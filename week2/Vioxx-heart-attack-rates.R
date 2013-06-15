# Heart attack data, Vioxx vs. Naproxen

library(epiR)

# Create table of heart attacks and person-time

TablePT <- matrix(c(17,4,2315,2316), 2, 2)
rownames(TablePT) <- c("Vioxx", "naproxen")
colnames(TablePT) <- c("Heart attacks", "Person-years")
TablePT

# Calculate incidence rate
epi.2by2(TablePT, method = "cohort.time")

# Create table of those who had heart attacks and those who did not
TableRisk <- matrix(c(17,4,4047-17,4029-4), 2, 2)
rownames(TableRisk) <- c("Vioxx", "naproxen")
colnames(TableRisk) <- c("Heart attacks", "No heart attacks")
TableRisk

# Calculate cumulative risk
epi.2by2(TableRisk, method = "cohort.count")