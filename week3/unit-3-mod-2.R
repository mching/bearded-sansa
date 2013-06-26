# If a couple have 5 children, what’s the probability that they have at least
# one boy (assuming boys and girls are equally likely)?

prob.boy <- 0.5
prob.no.boy <- 1 - prob.boy
prob.no.boy^5 # prob no boys in 5 children
1 - prob.no.boy^5 # prob at least 1 boy in 5 children