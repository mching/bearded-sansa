Week 3 R Exercise
====

## Introduction
I didn't write any exercises on probability since R doesn't really help you understand probability. However, sensitivity and specificity as well as positive and negative predictive values are relevant medical data analysis questions, particularly when you are trying to come up with a test that can predict a disease state.

If you are given one continuous variable (test result) and one categorical variable (disease status), you can see whether the categorical variable can be predicted from the continuous one. One way to do this is to create a cutoff point for the test. Above a certain value, you can call the result positive and below it negative. You can then see what are the sensitivity, specificity, positive predictive value and negative predictive value when looking at the real result.

There are many examples of this in medical diagnostic testing. The amount of activity of the elastase enzyme in a stool sample can be used to predict whether a patient has cystic fibrosis. However to do so, you have to have a cutoff point (i.e., below a certain level of elastase level, the patient likely has CF). Then you can run a trial to calculate sensitivity, specificity, PPV, and NPV.

## Dataset
I couldn't find a good medical dataset example so for this example we will use the `iris` dataset. This dataset comes preinstalled with most R installations. Use `?iris` to find out more about the data.

## Challenge
For simplicity, we will just look at the iris species *versicolor* and *virginica* and try to tell them apart by how long their petals are. If you want to pretend this is a medical problem, think of *versicolor* status as disease and petal length as a test result.

## Questions
1. Load the `iris` data and subset out the *setosa* species, keeping only *versicolor* and *virginica* species. Save the resulting subset in a new data frame.

2. Create a boxplot comparing the petal lengths of the two species (i.e., boxplot of petal length by species).

3. Recode the `Petal.Length` variable into a new binomial variable depending on whether the petal length is >= 5 or < 5.

4. Create a 2x2 table with the new variable as the rows and the species on the columns.

5. Calculate the sensitivity of your test for diagnosing an iris as `versicolor` in this dataset. What is the specificity? Positive predictive value? Negative predictive value?
