# Unit 3 Module 5
# CelluliteDX test

PPV <- 0.7
NPV <- 0.5

Table <- matrix(c(168, 32, 148, 52), 2)
rownames(Table) <- c("test+", "test-")
colnames(Table) <- c("disease+","disease-")
Table

