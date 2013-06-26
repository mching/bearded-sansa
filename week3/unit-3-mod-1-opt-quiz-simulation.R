# Make deck of cards
cards <- rep(1:13, 4)

# Set seed for replication
set.seed(1234)

# Create vector to save three card successes into
hands <- rep(NA, 100000)

# Draw 10000 samples (n=3) without replication.
for(i in 1:100000) {
  one.hand <- sample(cards, size = 3, replace = FALSE)
  hands[i] <- diff(range(one.hand)) < 1
}

prop.table(table(hands))
# This converges to the "right answer" of 1 * 3/51 * 2/50

# Lottery question
choose(47, 5)*27