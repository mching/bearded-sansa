prev.HIV <- 0.03
false.pos.rate <- 0.001
false.neg.rate <- 0.01

# probability of positive test if you randomly select a person with HIV
1 - false.neg.rate

# probability of selecting someone with HIV
prev.HIV

# prob of selecting someone with HIV and him/her testing positive
prev.HIV*(1- false.neg.rate)

# probability of positive test if you randomly select a person without HIV
false.pos.rate

# probability of selecting someone without HIV
1 - prev.HIV

# probability of selecting someone without HIV and testing positive
(1 - prev.HIV) * false.pos.rate

(1 - prev.HIV) * false.pos.rate + prev.HIV*(1- false.neg.rate)

# Probability of breast cancer in a 54 year old woman with abnl mammogram
# sens = 0.9, spec = 0.89, prevalence = 0.3%
# sens = disease and test positive over all people with disease
# spec = no disease and test negative over all people without disease

# Total prob of abnl mammo =
# prob(abnl mammo|ca)*prob(ca) + prob(abnl mammo|no ca)*prob(no ca)
(0.9)*(0.003) + (1-0.89)*(1-0.003)

# How many of those have cancer?, only prob(abnl mammo|ca)*prob(ca)

# prob of cancer?
(0.9)*(0.003) / ((0.9)*(0.003) + (1-0.89)*(1-0.003))
