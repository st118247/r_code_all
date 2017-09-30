library(neuralnet)
library(grid)
library(MASS)

?infert
dim(infert)
names(infert)
head(infert)

nn <- neuralnet(case~age+parity+induced+spontaneous,data = infert,hidden = 2,err.fct = "ce",
                linear.output = FALSE)

nn$result.matrix

nn$covariate

nn.bp <- neuralnet(case~age+parity+induced+spontaneous,data = infert,hidden = 2,err.fct = "ce",
                linear.output = FALSE, algorithm = "backprop", learningrate = 0.01)
