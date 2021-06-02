# 1.a
#a.	Read in the bank telemarketing data located here: CSV download link

url=url("https://guides.newman.baruch.cuny.edu/ld.php?content_id=39910549")
Default=read.csv(url)
str(Default)

# 1.b
#b.	Randomly split 80% of the data into the training set 
#and the remainder 20% into the test set. 
#Use set.seed(1) so that your results can be replicated by me.

set.seed(1)
train.index = sample(1:nrow(Default),nrow(Default)*0.8)
train = Default[train.index,]
test = Default[-train.index,]

# Number of observations in training and test set:
data.frame(full.size=nrow(Default),train.size=nrow(train),test.size=nrow(test))

# 2. 2A. 1
#1.	Fit a logistic regression model to the training data. 
# Which predictors are significant?

train$housing = as.character(train$housing)
train$housing[train$housing=="no"] = 0 
train$housing[train$housing=="yes"] = 1 
str(train$housing)
levels(train$housing)
train$contact = as.character(train$contact)
train$contact[train$contact=="unknown"] = 0 
train$contact[train$contact=="cellular"] = 1 
train$contact[train$contact=="telephone"] = 1 
str(train$contact)
levels

train$y = as.character(train$y)
train$y[train$y=="no"] = 0 
train$y[train$y=="yes"] = 1 
str(train$y)

train$housing=as.factor(train$housing)
train$contact=as.factor(train$contact)
train$y=as.factor(train$y)


str(train)

modelFull = glm(y~.,data=train,family=binomial)
summary(modelFull)

#2. 2B.1
#1.	Exponentiate the coefficients to convert them from log-odds to odds ratio.
exp(coef(modelFull))


#2. 2C. 1
# 1.	Compare the full model (with all predictors) versus a reduced model 
#with just predictors that describe characteristics of the marketing campaign 
#(duration, campaign, contact). Which is the better model in terms of AIC?
modelDuration = glm(y~duration,data=train,family=binomial)
summary(modelDuration)

modelCampaign = glm(y~campaign,data=train,family=binomial)
summary(modelCampaign)

modelContact = glm(y~contact,data=train,family=binomial)
summary(modelContact)

data.frame(full.model=AIC(modelFull),reduced.model1=AIC(modelDuration),reduced.model2=AIC(modelCampaign),reduced.model3=AIC(modelContact))

#2. 2D. 1
#1.	Use the better model to make predictions on the test set with a decision threshold of 50%. 
#Provide the confusion matrix. How well does the model do in terms of 
#accuracy, sensitivity of "yes", and precision of "yes"?
test$housing = as.character(test$housing)
test$housing[test$housing=="no"] = 0 
test$housing[test$housing=="yes"] = 1 
str(test$housing)
levels(test$housing)
test$contact = as.character(test$contact)
test$contact[test$contact=="unknown"] = 0 
test$contact[test$contact=="cellular"] = 1 
test$contact[test$contact=="telephone"] = 1 
str(test$contact)

test$y = as.character(test$y)
test$y[test$y=="no"] = 0 
test$y[test$y=="yes"] = 1 
str(test$y)

test$housing=as.factor(test$housing)
test$contact=as.factor(test$contact)
test$y=as.factor(test$y)


str(test)
pred.prob = predict(modelFull,test,type="response")
pred.prob[1:10]

pred.class = pred.prob

pred.class[pred.prob>0.5] = "Yes"
pred.class[!pred.prob>0.5] = "No"

pred.class[1:10]

c.matrix = table(actual=test$y,pred.class)
c.matrix

acc = mean(pred.class==test$y)
sens.yes = c.matrix[4]/(c.matrix[2]+c.matrix[4])
prec.yes = c.matrix[4]/(c.matrix[3]+c.matrix[4])

data.frame(acc,sens.yes,prec.yes)


#2. 2D. 2
#2.	Change the decision threshold to >80%="yes". 
#How does the sensitivity and precision change? 
#Given the business goal, would it be better to 
#increase or decrease the decision threshold for "yes"?
pred.class = pred.prob

pred.class[pred.prob>0.8] = "Yes"
pred.class[!pred.prob>0.8] = "No"

pred.class[1:10]
c.matrix = table(actual=test$y,pred.class)
c.matrix

acc = mean(pred.class==test$y)
sens.yes = c.matrix[4]/(c.matrix[2]+c.matrix[4])
prec.yes = c.matrix[4]/(c.matrix[3]+c.matrix[4])

data.frame(acc,sens.yes,prec.yes)

# 3. 1.
#1.	With set.seed(1), build a random forest model on the training set. 
#How many trees were built? How many predictors were randomly considered at each split? 
#What is the out-of-bag estimated test error?
library(randomForest)

set.seed(1)
reg.model = randomForest(y~.,data=train); reg.model

# 3. 2
#2.	Make predictions on the test set and evaluate the confusion matrix. 
#Calculate accuracy, sensitivity, and precision. 
#How does it compare against the logistic regression model? 
#Better, worse, or about the same?
cl.model = randomForest(y~.,data=test,importance=TRUE)
cl.model
pred.cl = predict(cl.model,test)

c.matrix = table(test$y,pred.cl); c.matrix
acc = mean(pred.class==test$default)
sens.yes = c.matrix[4]/(c.matrix[2]+c.matrix[4])
prec.yes = c.matrix[4]/(c.matrix[3]+c.matrix[4])

data.frame(acc,sens.yes,prec.yes)

# 3. 3
#3.	Create the variable importance plot. 
#What is the most important variable in predicting 
#whether the customer will subscribe to the product after being contacted by the marketing team?
varImpPlot(cl.model,main="Variable Importance Plots")


###Extra Credit

