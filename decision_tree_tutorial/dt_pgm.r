# Classification tree model
library(ISLR)
library(tree)

attach(Carseats)
head(Carseats)

# Data manipulation 
range(Sales)

# Convert sales to catrgorical values
# Crete categorical value High based on sales variable
# if sales >= 8 
High = ifelse(Sales >= 8, "Yes","No")

# Count of High
Length(High)

# append High vector to Carsets 
Carseats_new = data.frame(Carseats,High)

# get the dimensions for Carseats_new
dim(Carseats_new)

# take the first column away, no sense to put sales column
Carseats_new = Carseats_new[,-1]

# random set to seperate the data in to training and testing set
set.seed(2)
train = sample(1:nrow(Carseats_new),nrow(Carseats_new)/2)
test = -train

training_data = Carseats_new[train,]
testing_data = Carseats_new[test,]
testing_High = High[test]

# fit the new tree model using training data
tree_model = tree(High~.,training_data)

plot(tree_model)
text(tree_model)

text(tree_model,pretty = 0)

# check how the tree model performs using test data
tree_pred = predict(tree_model,testing_data,type = "class")

mean(tree_pred != testing_High)   # 28.5% error 

## prune the tree 

# Cross validation to check where to stop pruning

set.seed(3)

cv_tree = cv.tree(tree_model, FUN=prune.misclass)

