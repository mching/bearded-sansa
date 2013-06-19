# Unit 2 Module 4 Lecture 3 Quiz
# 1. If 40% of a treated group has a positive response versus just 10% of the
# placebo group, what are the risk ratio and odds ratio (for treatment vs.
# placebo)?

response.treated <- 0.4
response.placebo <- 0.1

# Risk ratio
response.treated/response.placebo

odds.treated <- response.treated/(1-response.treated)
odds.placebo <- response.placebo/(1-response.placebo)

odds.treated
odds.placebo

# Odds ratio
odds.treated/odds.placebo