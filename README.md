# Classification-2
Part 1: Classification

1. The Data:
Read in the bank telemarketing data located here: CSV download link
Randomly split 80% of the data into the training set and the remainder 20% into the test set. Use set.seed(1) so that your results can be replicated by me.

2. Logistic regression:
In this section, we will use logistic regression to predict “y” (whether the client will subscribe to the term deposit after the marketing call).
2A. Model building
Fit a logistic regression model to the training data. Which predictors are significant?

2B. Interpreting coefficients
Exponentiate the coefficients to convert them from log-odds to odds ratio.
As the duration of the marketing interaction increases, do we expect the odds of the person subscribing to increase or decrease? Why?
If the customer has a housing loan, how much do we expect the odds of them subscribing to increase or decrease?

2C. Model comparison
Compare the full model (with all predictors) versus a reduced model with just predictors that describe characteristics of the marketing campaign (duration, campaign, contact). Which is the better model in terms of AIC?

2D. Predictions
Use the better model to make predictions on the test set with a decision threshold of 50%. Provide the confusion matrix. How well does the model do in terms of accuracy, sensitivity of “yes”, and precision of “yes”?
Change the decision threshold to >80%=”yes”. How does the sensitivity and precision change? Given the business goal, would it be better to increase or decrease the decision threshold for “yes”?

3. Random Forest:
With set.seed(1), build a random forest model on the training set. How many trees were built? How many predictors were randomly considered at each split? What is the out-of-bag estimated test error?
Make predictions on the test set and evaluate the confusion matrix. Calculate accuracy, sensitivity, and precision. How does it compare against the logistic regression model? Better, worse, or about the same?
Create the variable importance plot. What is the most important variable in predicting whether the customer will subscribe to the product after being contacted by the marketing team?









Part 2: Clustering (Extra Credit)

For part 2, instead of predicting a value or outcome, we are interested in finding subgroups within our data using clustering algorithms.

Data preparation:

Load in the College dataset from the ISLR package (previously used in HW3). The goal is to find groupings of similar US colleges and define characteristics of those clusters.
Using the str( ) function, we see one of the variables is categorical. We can either convert it to a dummy variable or remove it from the dataset. Since we have plenty of other variables to work with, let’s choose to remove it at this time.
The rest of the variables are continuous and of varying ranges, so we should standardize the data to mean 0 and standard deviation 1 with the scale( ) function.

K-means clustering:

Using set.seed(1), cluster the data into 2 groups with kmeans( ) function. Set nstart=10 to select the best 2-cluster grouping (based on lowest within-group sum of squares) out of 10 reruns.
What is the total of the within-group sum of squares across the clusters?
Analyze the descriptive statistics for the two clusters. How would you profile/characterize the clusters?

Hierarchical clustering:

Using the “complete” linkage type, cluster the data with the hclust( ) function. Plot it.
Use the cutree( ) function to cut the tree at 2 clusters. 
Analyze the descriptive statistics for the two clusters. Do the clusters have the same profiles from the k-means clustering or do they have a different representation?
Which cluster does Boston University belong to?
