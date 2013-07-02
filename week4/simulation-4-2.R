# Computer simulation of Module 4 correlation coefficient

# Generate the Vitamin D and Cognitive test score variables
# Code in this section comes from the following discussion:
# http://stats.stackexchange.com/questions/15011/generate-a-random-variable-with-a-defined-correlation-to-an-existing-variable/15040#15040
# I didn't take the time to figure out how to make a right skewed distribution with
# the specified mean and standard deviation

set.seed(90095)

n     <- 10000                 # length of vector
rho   <- 0.15                  # desired correlation = cos(angle)
theta <- acos(rho)             # corresponding angle
x1    <- rnorm(n, 62, 33)      # fixed given data
x2    <- rnorm(n, 2, 0.5)      # new random data
X     <- cbind(x1, x2)         # matrix
Xctr  <- scale(X, center=TRUE, scale=FALSE)   # centered columns (mean 0)

Id   <- diag(n)                               # identity matrix
Q    <- qr.Q(qr(Xctr[ , 1, drop=FALSE]))      # QR-decomposition, just matrix Q
P    <- tcrossprod(Q)          # = Q Q'       # projection onto space defined by x1
x2o  <- (Id-P) %*% Xctr[ , 2]                 # x2ctr made orthogonal to x1ctr
Xc2  <- cbind(Xctr[ , 1], x2o)                # bind to matrix
Y    <- Xc2 %*% diag(1/sqrt(colSums(Xc2^2)))  # scale columns to length 1

x <- Y[ , 2] + (1 / tan(theta)) * Y[ , 1]     # final new vector
cor(x1, x)                                    # check correlation = rho


# Rename variables to make them correspond to the video
VitD <- x1
cognitive <- x


# Run the repeated simulations
results <- rep(NA, 10000)
for(i in 1:10000) {
  index <- sample(10000, 100, replace = F)
  results[i] <- cor(VitD[index], cognitive[index])
}

# Look at the results by histogram, mean, and standard error of the mean
hist(results)
mean(results)
sd(results)

# Compare to the theoretical standard error
(1-0.15^2)^.5/10